provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "security_scanner" {
  function_name = "SecurityScanner"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  filename      = "my-code.zip"
}
