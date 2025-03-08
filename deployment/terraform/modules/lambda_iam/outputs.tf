output "lambda_iam_arn" {
  description = "IAM Security Scanner Lambda ARN"
  value       = aws_lambda_function.lambda_iam.arn
}

output "lambda_iam_invoke_arn" {
  description = "IAM Security Scanner Lambda Invoke ARN"
  value       = aws_lambda_function.lambda_iam.invoke_arn
}
