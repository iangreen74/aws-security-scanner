from src.iam_scanner import check_iam_security


def test_iam_scanner():
    """Test that IAM scanner runs without errors and returns a list."""
    result = check_iam_security()
    assert isinstance(result, list)
