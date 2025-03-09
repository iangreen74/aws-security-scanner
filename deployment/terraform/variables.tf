variable "notification_email" {
  default = "your-email@example.com"
}

variable "lambda_role_arn" {
  description = "ARN of the IAM Role for Lambda execution"
  type        = string
}
