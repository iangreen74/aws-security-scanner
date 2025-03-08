import boto3
import json
import os

s3_client = boto3.client("s3")
BUCKET_NAME = os.environ.get("SECURITY_REPORT_BUCKET")

def lambda_handler(event, context):
    print("[*] Running S3 Security Scanner...")
    findings = []

    try:
        buckets = s3_client.list_buckets()["Buckets"]
        for bucket in buckets:
            acl = s3_client.get_bucket_acl(Bucket=bucket["Name"])
            for grant in acl["Grants"]:
                if grant["Grantee"].get("URI") == "http://acs.amazonaws.com/groups/global/AllUsers":
                    findings.append(f"Bucket {bucket['Name']} is publicly accessible!")

        # Save findings to S3
        s3_client.put_object(Bucket=BUCKET_NAME, Key="s3_findings.json", Body=json.dumps(findings))
    except Exception as e:
        findings.append(f"Error scanning S3: {str(e)}")

    return {"statusCode": 200, "body": json.dumps(findings)}
