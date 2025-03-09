variable "lambda_package" {}
variable "sns_topic_arn" {}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for the Lambda function"
  type        = string
}
