import boto3

def check_iam_security():
    print("[*] Checking IAM security...")
    client = boto3.client('iam')
    findings = []

    # Check for IAM users without MFA enabled
    users = client.list_users()['Users']
    for user in users:
        mfa = client.list_mfa_devices(UserName=user['UserName'])
        if not mfa['MFADevices']:
            findings.append(f"User '{user['UserName']}' has no MFA enabled.")

    return findings
