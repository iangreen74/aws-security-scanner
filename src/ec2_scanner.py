import pytest
import src.ec2_scanner  # ✅ Import the module, not just the function

def test_ec2_scanner():
    event = {}
    context = {}
    response = src.ec2_scanner.lambda_handler(event, context)  # ✅ Call function via module
    
    assert isinstance(response, dict)
    assert "statusCode" in response
    assert response["statusCode"] == 200
