provider "aws" {
  region = "us-east-1"
}

resource "random_string" "lambda_suffix" {
  length  = 6
  special = false
  upper   = false
}

module "sns" {
  source             = "./modules/sns"
  notification_email = "your-email@example.com"
}

module "iam" {
  source        = "./modules/iam"
  sns_topic_arn = module.sns.sns_topic_arn
}

module "lambda_ec2" {
  source                 = "./modules/lambda_ec2"
  lambda_role_arn        = module.iam.lambda_role_arn
  security_report_bucket = "security-scanner-reports"
}

module "lambda_s3" {
  source = "./modules/lambda_s3"
}

module "lambda_iam" {
  source          = "./modules/lambda_iam"
  lambda_role_arn = aws_iam_role.lambda_exec.arn       # ✅ Pass IAM role
  lambda_suffix   = random_string.lambda_suffix.result # ✅ Pass random suffix
}

module "lambda_report" {
  source          = "./modules/lambda_report"
  lambda_role_arn = aws_iam_role.lambda_exec.arn       # ✅ Pass IAM role
  lambda_suffix   = random_string.lambda_suffix.result # ✅ Pass random suffix
}
