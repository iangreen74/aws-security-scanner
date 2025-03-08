import pytest
import src.s3_scanner  # ✅ Import the module

def test_s3_scanner():
    event = {}
    context = {}
    response = src.s3_scanner.lambda_handler(event, context)  # ✅ Call function via module
    
    assert isinstance(response, dict)
    assert "statusCode" in response
    assert response["statusCode"] == 200
