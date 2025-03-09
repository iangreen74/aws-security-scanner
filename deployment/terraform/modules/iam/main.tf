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

resource "aws_iam_policy" "lambda_sns_publish" {
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

resource "aws_iam_role_policy_attachment" "lambda_sns_attach" {
  role       = aws_iam_role.lambda_exec[0].name # ✅ Fix count reference
  policy_arn = aws_iam_policy.lambda_sns_publish.arn
}
