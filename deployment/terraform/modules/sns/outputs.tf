output "sns_topic_arn" {
  description = "ARN of the SNS Topic"
  value       = aws_sns_topic.security_alerts.arn
}
