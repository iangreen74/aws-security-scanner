from src.s3_scanner import check_s3_security


def test_s3_scanner():
    """Test that S3 scanner runs without errors and returns a list."""
    result = check_s3_security()
    assert isinstance(result, list)
