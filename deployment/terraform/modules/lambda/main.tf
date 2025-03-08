resource "aws_lambda_function" "security_scanner" {
  function_name = "SecurityScanner"
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  filename      = "${path.module}/my-code.zip" # ✅ Ensure correct ZIP path

  environment {
    variables = {
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}
