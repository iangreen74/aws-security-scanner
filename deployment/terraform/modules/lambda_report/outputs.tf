output "lambda_report_arn" {
  description = "ARN of the Report Generator Lambda function"
  value       = aws_lambda_function.lambda_report.arn
}

output "lambda_report_invoke_arn" {
  description = "Invoke ARN of the Report Generator Lambda function"
  value       = aws_lambda_function.lambda_report.invoke_arn
}
