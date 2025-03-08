resource "aws_sns_topic" "security_alerts" {
  name = "SecurityAlerts"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = var.notification_email # User-defined email
}

# Output SNS Topic ARN for Lambda
output "sns_topic_arn" {
  value = aws_sns_topic.security_alerts.arn
}
