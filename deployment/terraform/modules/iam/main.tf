data "aws_iam_role" "existing_lambda_exec" {
  name = "SecurityScannerLambdaRole"
}

resource "aws_iam_role" "lambda_exec" {
  name = "LambdaExecutionRole"

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

data "aws_iam_policy" "existing_lambda_sns_publish" {
  name = "LambdaSNSPublishPolicy"
}

resource "aws_iam_policy" "lambda_sns_publish" {
  count       = length(data.aws_iam_policy.existing_lambda_sns_publish) == 0 ? 1 : 0
  name        = "LambdaSNSPublishPolicy"
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

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}


resource "aws_iam_role_policy_attachment" "lambda_sns_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_sns_publish.arn
}
