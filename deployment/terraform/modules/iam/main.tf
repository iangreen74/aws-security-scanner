# Try to retrieve an existing IAM role
data "aws_iam_role" "existing_lambda_exec" {
  name = "SecurityScannerLambdaRole"
}

# Only create the IAM role if it does not exist
resource "aws_iam_role" "lambda_exec" {
  count = can(data.aws_iam_role.existing_lambda_exec.arn) ? 0 : 1 # ✅ Corrected check

  name = "SecurityScannerLambdaRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
