variable "lambda_role_arn" {
  description = "IAM Role ARN for Lambda function"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic for security notifications"
  type        = string
}

variable "security_report_bucket" {
  description = "S3 bucket for storing security reports"
  type        = string
}

variable "lambda_suffix" {
  description = "Random string suffix for Lambda function name"
  type        = string
}
