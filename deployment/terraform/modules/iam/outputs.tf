output "lambda_role_arn" {
  value = can(data.aws_iam_role.existing_lambda_exec.arn) ? data.aws_iam_role.existing_lambda_exec.arn : aws_iam_role.lambda_exec[0].arn
}
