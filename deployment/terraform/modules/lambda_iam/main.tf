resource "random_string" "lambda_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_lambda_function" "lambda_iam" {
  function_name = "IAMSecurityScanner-${random_string.lambda_suffix.result}"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = "5m"
    update = "5m"
  }
}
