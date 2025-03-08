from src.scanner import run_scanner

def lambda_handler(event, context):
    run_scanner()
    return {
        "statusCode": 200,
        "body": "AWS Security Scan Completed"
    }
