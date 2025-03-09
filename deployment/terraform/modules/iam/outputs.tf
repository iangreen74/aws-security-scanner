output "lambda_sns_policy_arn" {
  description = "ARN of the Lambda SNS Policy"
  value       = aws_iam_policy.lambda_sns_publish.arn
}

output "lambda_role_arn" {
  description = "ARN of the Lambda Execution Role"
  value       = aws_iam_role.lambda_exec.arn
}
