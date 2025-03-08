import json

def generate_report(findings):
    with open("examples/security_report.json", "w") as report_file:
        json.dump(findings, report_file, indent=4)
    print("[+] Security report saved to 'examples/security_report.json'.")
