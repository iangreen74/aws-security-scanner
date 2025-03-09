# Generate a unique suffix to ensure new IAM resources are created
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

data "aws_iam_role" "existing" {
  name = "LambdaExecutionRole"
}

resource "aws_iam_role" "lambda_exec" {
  count = length(data.aws_iam_role.existing) > 0 ? 0 : 1 # ✅ Create only if it doesn't exist
  name  = "LambdaExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create a NEW IAM Policy for SNS Publishing
resource "aws_iam_policy" "lambda_sns_publish" {
  name        = "LambdaSNSPublishPolicy-${random_string.suffix.result}"
  description = "Allows Lambda to publish to SNS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "sns:Publish"
      Resource = "*"
    }]
  })
}

# Attach the IAM Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "lambda_sns_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_sns_publish.arn
}

# Ensure IAM Role and Policy Cleanup Before Creating New Ones
resource "null_resource" "iam_cleanup" {
  triggers = {
    lambda_role_name = aws_iam_role.lambda_exec.name
    policy_name      = aws_iam_policy.lambda_sns_publish.name
  }

  provisioner "local-exec" {
    command = <<EOT
      aws iam delete-role-policy --role-name ${aws_iam_role.lambda_exec.name} --policy-name ${aws_iam_policy.lambda_sns_publish.name} || true
      aws iam detach-role-policy --role-name ${aws_iam_role.lambda_exec.name} --policy-arn ${aws_iam_policy.lambda_sns_publish.arn} || true
      aws iam delete-role --role-name ${aws_iam_role.lambda_exec.name} || true
      aws iam delete-policy --policy-arn ${aws_iam_policy.lambda_sns_publish.arn} || true
    EOT
  }
}
