# Generate a unique suffix to ensure new IAM resources are created
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Fetch existing IAM Role (if it exists)
data "aws_iam_role" "existing" {
  name = "LambdaExecutionRole"
}

# Create IAM Role if it does NOT exist
resource "aws_iam_role" "lambda_exec" {
  count = data.aws_iam_role.existing.id != "" ? 0 : 1 # ✅ Create only if role is missing
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

# Attach Basic Lambda Execution Role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  count      = length(aws_iam_role.lambda_exec) > 0 ? 1 : 0 # ✅ Only attach if role exists
  role       = aws_iam_role.lambda_exec[0].name
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
  count      = length(aws_iam_role.lambda_exec) > 0 ? 1 : 0 # ✅ Only attach if role exists
  role       = aws_iam_role.lambda_exec[0].name
  policy_arn = aws_iam_policy.lambda_sns_publish.arn
}
