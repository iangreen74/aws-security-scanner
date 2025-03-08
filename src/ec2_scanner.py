import boto3

def check_ec2_security():
    print("[*] Checking EC2 security groups...")
    client = boto3.client('ec2')
    findings = []

    security_groups = client.describe_security_groups()['SecurityGroups']
    for sg in security_groups:
        for rule in sg['IpPermissions']:
            for ip_range in rule.get('IpRanges', []):
                if ip_range['CidrIp'] == "0.0.0.0/0" and rule['IpProtocol'] in ['tcp', '-1']:
                    findings.append(f"Security Group '{sg['GroupName']}' allows inbound traffic from anywhere on {rule['IpProtocol']} port(s).")

    return findings
