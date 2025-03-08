resource "aws_lambda_function" "security_scanner" {
  function_name = "SecurityScanner"
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  filename      = var.lambda_package

  environment {
    variables = {
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}

# Output Lambda ARN for other modules
output "lambda_arn" {
  value = aws_lambda_function.security_scanner.arn
}
