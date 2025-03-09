# Generate a unique suffix to ensure new IAM resources are created
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Create a NEW IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_exec" {
  name = "LambdaExecutionRole-${random_string.suffix.result}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
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
