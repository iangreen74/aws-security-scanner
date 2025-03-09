resource "aws_s3_bucket" "security_reports" {
  bucket = var.bucket_name != null ? var.bucket_name : "security-reports-${random_string.bucket_suffix.result}"
  acl    = var.bucket_acl
}

resource "random_string" "bucket_suffix" {
  length  = 6
  special = false
  upper   = false
}
