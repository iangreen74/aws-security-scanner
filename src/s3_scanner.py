import boto3

def check_s3_security():
    print("[*] Checking S3 security...")
    client = boto3.client('s3')
    findings = []

    buckets = client.list_buckets()['Buckets']
    for bucket in buckets:
        acl = client.get_public_access_block(Bucket=bucket['Name'])
        if not acl['PublicAccessBlockConfiguration']['BlockPublicAcls']:
            findings.append(f"Bucket '{bucket['Name']}' is publicly accessible!")

    return findings
