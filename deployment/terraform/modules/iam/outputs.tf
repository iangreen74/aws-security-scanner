output "lambda_role_arn" {
  value = aws_iam_role.lambda_exec[0].arn # ✅ Fix count reference
}
