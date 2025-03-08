import boto3
import json
import os

s3_client = boto3.client("s3")
BUCKET_NAME = os.environ.get("SECURITY_REPORT_BUCKET")

def lambda_handler(event, context):
    findings = []
    buckets = s3_client.list_buckets()["Buckets"]
    
    for bucket in buckets:
        acl = s3_client.get_bucket_acl(Bucket=bucket["Name"])
        for grant in acl["Grants"]:
            if grant["Grantee"].get("URI") == "http://acs.amazonaws.com/groups/global/AllUsers":
                findings.append(f"Bucket {bucket['Name']} is publicly accessible!")

    s3_client.put_object(Bucket=BUCKET_NAME, Key="s3_findings.json", Body=json.dumps(findings))

    return {"statusCode": 200, "body": json.dumps(findings)}
