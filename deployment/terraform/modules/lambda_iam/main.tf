resource "aws_lambda_function" "lambda_iam" {
  function_name    = "IAMSecurityScanner"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  environment {
    variables = {
      SNS_TOPIC_ARN          = var.sns_topic_arn
      SECURITY_REPORT_BUCKET = var.security_report_bucket
    }
  }
}
