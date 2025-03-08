import boto3
import json
import os

s3_client = boto3.client("s3")
sns_client = boto3.client("sns")

BUCKET_NAME = os.environ.get("SECURITY_REPORT_BUCKET")
SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")

def lambda_handler(event, context):
    print("[*] Generating Security Report...")
    findings = {}

    try:
        for scanner in ["ec2", "s3", "iam"]:
            try:
                obj = s3_client.get_object(Bucket=BUCKET_NAME, Key=f"{scanner}_findings.json")
                findings[scanner] = json.loads(obj["Body"].read().decode("utf-8"))
            except Exception as e:
                findings[scanner] = f"Error retrieving findings: {str(e)}"

        # Publish findings to SNS
        sns_client.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=json.dumps(findings, indent=4),
            Subject="AWS Security Scan Report"
        )
    except Exception as e:
        return {"statusCode": 500, "body": f"Error generating report: {str(e)}"}

    return {"statusCode": 200, "body": "Report Sent!"}
