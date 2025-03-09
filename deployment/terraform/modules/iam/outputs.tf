output "lambda_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_exec.arn
}

output "lambda_sns_policy_arn" {
  description = "ARN of the Lambda SNS publish policy"
  value       = aws_iam_policy.lambda_sns_publish.arn # ✅ Fixed indexing issue
}
