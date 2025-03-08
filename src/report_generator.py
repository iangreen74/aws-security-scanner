import json

def generate_report(findings):
    """Generate a JSON security report and store it in a writable location (`/tmp/`)."""
    report_path = "/tmp/security_report.json"  # ✅ Save in `/tmp/` instead of `examples/`
    
    with open(report_path, "w") as report_file:
        json.dump(findings, report_file, indent=4)
    
    print(f"✅ Security report saved at {report_path}")
