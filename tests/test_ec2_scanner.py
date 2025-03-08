import pytest
from src.ec2_scanner import lambda_handler  # ✅ Correct function import

def test_ec2_scanner():
    event = {}
    context = {}
    response = lambda_handler(event, context)
    
    assert isinstance(response, dict)
    assert "statusCode" in response
    assert response["statusCode"] == 200
