output "lambda_role_arn" {
  value = aws_iam_role.lambda_exec[0].arn # ✅ Fix count reference
}

output "lambda_sns_policy_arn" {
  description = "IAM Policy ARN allowing Lambda to publish to SNS"
  value       = aws_iam_policy.lambda_sns_publish.arn
}
