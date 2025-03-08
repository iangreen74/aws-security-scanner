from src.ec2_scanner import check_ec2_security


def test_ec2_scanner():
    """Test that EC2 scanner runs without errors and returns a list."""
    result = check_ec2_security()
    assert isinstance(result, list)
