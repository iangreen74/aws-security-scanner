variable "lambda_role_arn" {
  description = "IAM Role ARN for the Lambda function"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS Topic ARN for notifications"
  type        = string
}

variable "lambda_sns_policy_arn" {
  description = "IAM Policy ARN allowing Lambda to publish to SNS"
  type        = string
}
