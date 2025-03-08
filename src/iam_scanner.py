import pytest
import src.iam_scanner  # ✅ Import the module

def test_iam_scanner():
    event = {}
    context = {}
    response = src.iam_scanner.lambda_handler(event, context)  # ✅ Call function via module
    
    assert isinstance(response, dict)
    assert "statusCode" in response
    assert response["statusCode"] == 200
