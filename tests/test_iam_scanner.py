import pytest
from src.iam_scanner import lambda_handler  # ✅ Correct function import

def test_iam_scanner():
    event = {}
    context = {}
    response = lambda_handler(event, context)
    
    assert isinstance(response, dict)
    assert "statusCode" in response
    assert response["statusCode"] == 200
