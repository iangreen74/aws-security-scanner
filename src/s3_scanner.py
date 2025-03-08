import pytest
from src.s3_scanner import lambda_handler  # ✅ Correct function import

def test_s3_scanner():
    event = {}
    context = {}
    response = lambda_handler(event, context)
    
    assert isinstance(response, dict)
    assert "statusCode" in response
    assert response["statusCode"] == 200
