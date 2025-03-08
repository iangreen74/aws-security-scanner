import boto3
import json
import os

s3_client = boto3.client("s3")
SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")

def lambda_handler(event, context):
    findings = {}

    # Read findings from S3 (assuming each scanner writes a file)
    for scanner in ["ec2", "s3", "iam"]:
        try:
            obj = s3_client.get_object(Bucket="security-scanner-reports", Key=f"{scanner}_findings.json")
            findings[scanner] = json.loads(obj["Body"].read().decode("utf-8"))
        except Exception as e:
            findings[scanner] = f"Error retrieving findings: {str(e)}"

    # Send final report via SNS
    sns_client = boto3.client("sns")
    sns_client.publish(
        TopicArn=SNS_TOPIC_ARN,
        Message=json.dumps(findings, indent=4),
        Subject="AWS Security Scan Report"
    )

    return {"statusCode": 200, "body": "Report Sent!"}
