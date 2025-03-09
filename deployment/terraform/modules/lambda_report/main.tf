resource "random_string" "lambda_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_lambda_function" "lambda_report" {
  function_name = "ReportGenerator-${random_string.lambda_suffix.result}"
  role          = var.lambda_role_arn
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
