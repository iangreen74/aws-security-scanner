data "aws_iam_role" "existing_lambda_exec" {
  name = "SecurityScannerLambdaRole"
}

resource "aws_iam_role" "lambda_exec" {
  count = length(data.aws_iam_role.existing_lambda_exec) > 0 ? 0 : 1 # ✅ Avoids duplicate role creation
  name  = "SecurityScannerLambdaRole"

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

data "aws_iam_policy" "existing_lambda_sns_publish" {
  name = "LambdaSNSPublishPolicy"
}

resource "aws_iam_policy" "lambda_sns_publish" {
  count       = length(data.aws_iam_policy.existing_lambda_sns_publish) > 0 ? 0 : 1 # ✅ Avoids duplicate policy creation
  name        = "LambdaSNSPublishPolicy"
  description = "Allows Lambda to publish to SNS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sns:Publish"
        Resource = var.sns_topic_arn
      }
    ]
  })
}
