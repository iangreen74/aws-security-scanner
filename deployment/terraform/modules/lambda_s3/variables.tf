variable "bucket_name" {
  description = "Custom name for the security reports S3 bucket (optional)"
  type        = string
  default     = null
}

variable "bucket_acl" {
  description = "ACL for the security reports S3 bucket"
  type        = string
  default     = "private"
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for the Lambda function"
  type        = string
}
