import boto3
import json
import os

s3_client = boto3.client("s3")
iam_client = boto3.client("iam")
BUCKET_NAME = os.environ.get("SECURITY_REPORT_BUCKET")

def lambda_handler(event, context):
    findings = []
    users = iam_client.list_users()["Users"]

    for user in users:
        mfa = iam_client.list_mfa_devices(UserName=user["UserName"])
        if not mfa["MFADevices"]:
            findings.append(f"User {user['UserName']} has no MFA enabled!")

    s3_client.put_object(Bucket=BUCKET_NAME, Key="iam_findings.json", Body=json.dumps(findings))

    return {"statusCode": 200, "body": json.dumps(findings)}
