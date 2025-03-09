resource "aws_lambda_function" "lambda_report" {
  function_name = "ReportGenerator-${random_string.lambda_suffix.result}"
  role          = var.lambda_role_arn # ✅ Use the IAM role passed as a variable
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
