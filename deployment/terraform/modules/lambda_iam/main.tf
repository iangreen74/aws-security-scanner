resource "aws_lambda_function" "lambda_iam" {
  function_name    = "IAMSecurityScanner"
  role             = var.lambda_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  filename         = "${path.module}/lambda_function.zip"                   # ✅ Ensure file exists
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip") # ✅ Compute hash

  environment {
    variables = {
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}
