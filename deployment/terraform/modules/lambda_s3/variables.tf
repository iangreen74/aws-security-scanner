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
