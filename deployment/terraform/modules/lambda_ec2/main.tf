resource "aws_lambda_function" "ec2_scanner" {
  function_name = "EC2SecurityScanner"
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  filename      = "${path.module}/my-code-ec2.zip"

  environment {
    variables = {
      SECURITY_REPORT_BUCKET = var.security_report_bucket
    }
  }
}
