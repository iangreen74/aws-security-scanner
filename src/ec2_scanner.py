import boto3
import json
import os

s3_client = boto3.client("s3")
ec2_client = boto3.client("ec2")

BUCKET_NAME = os.environ.get("SECURITY_REPORT_BUCKET")

def lambda_handler(event, context):
    findings = []

    security_groups = ec2_client.describe_security_groups()["SecurityGroups"]
    for sg in security_groups:
        for rule in sg.get("IpPermissions", []):
            if rule.get("IpRanges") and any(ip["CidrIp"] == "0.0.0.0/0" for ip in rule["IpRanges"]):
                findings.append(f"Security Group {sg['GroupId']} allows open access!")

    s3_client.put_object(Bucket=BUCKET_NAME, Key="ec2_findings.json", Body=json.dumps(findings))
    
    return {"statusCode": 200, "body": json.dumps(findings)}
