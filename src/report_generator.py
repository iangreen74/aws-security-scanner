import json
import boto3

sns_client = boto3.client("sns")
SNS_TOPIC_ARN = "arn:aws:sns:us-east-1:418295677815:SecurityAlerts"

def generate_report(findings):
    """Generate a JSON security report and send as an email via SNS."""
    report_message = json.dumps(findings, indent=4)

    sns_client.publish(
        TopicArn=SNS_TOPIC_ARN,
        Message=report_message,
        Subject="AWS Security Scan Report"
    )
    print("✅ Security report sent via AWS SNS.")
