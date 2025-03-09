output "bucket_name" {
  description = "S3 Bucket for storing security reports"
  value       = aws_s3_bucket.security_reports.id
}
