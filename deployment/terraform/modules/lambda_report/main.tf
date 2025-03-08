resource "aws_lambda_function" "lambda_report" {
  function_name    = "ReportGenerator"
  role             = var.lambda_role_arn # ✅ Use variable instead of undefined IAM role
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  environment {
    variables = {
      SNS_TOPIC_ARN = var.sns_topic_arn # ✅ Use input variable
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_report_sns" {
  role       = var.lambda_role_arn       # ✅ Use variable instead of undefined reference
  policy_arn = var.lambda_sns_policy_arn # ✅ Use input variable
}
