output "lambda_sns_policy_arn" {
  description = "ARN of the Lambda SNS Policy"
  value       = aws_iam_policy.lambda_sns_publish.arn
}

output "lambda_role_arn" {
  value = length(aws_iam_role.lambda_exec) > 0 ? aws_iam_role.lambda_exec[0].arn : data.aws_iam_role.existing.arn
}
