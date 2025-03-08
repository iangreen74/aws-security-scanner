from src.iam_scanner import check_iam_security
from src.s3_scanner import check_s3_security
from src.ec2_scanner import check_ec2_security
from src.report_generator import generate_report


def run_scanner():
    print("[+] Running AWS Security Scanner...")

    iam_findings = check_iam_security()
    s3_findings = check_s3_security()
    ec2_findings = check_ec2_security()

    findings = {
        "IAM_Security": iam_findings,
        "S3_Security": s3_findings,
        "EC2_Security": ec2_findings
    }

    generate_report(findings)
    print("[+] Security scan completed.")


if __name__ == "__main__":
    run_scanner()
