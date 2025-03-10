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
  notification_email = "mikahiangreen@gmail.com"
  lambda_role_arn    = module.iam.lambda_role_arn
}

module "iam" {
  source          = "./modules/iam"
  sns_topic_arn   = module.sns.sns_topic_arn # ✅ Now properly defined
  lambda_role_arn = var.lambda_role_arn
}

module "lambda_ec2" {
  source                 = "./modules/lambda_ec2"
  lambda_role_arn        = module.iam.lambda_role_arn
  security_report_bucket = "security-scanner-reports"
}

module "lambda_s3" {
  source          = "./modules/lambda_s3"
  bucket_name     = "my-security-reports-bucket" # Optional: Override default
  bucket_acl      = "private"
  lambda_role_arn = module.iam.lambda_role_arn
}

module "lambda_iam" {
  source                 = "./modules/lambda_iam"
  lambda_role_arn        = module.iam.lambda_role_arn
  lambda_suffix          = random_string.lambda_suffix.result
  sns_topic_arn          = module.sns.sns_topic_arn
  security_report_bucket = module.lambda_s3.bucket_name
}

module "lambda_report" {
  source                = "./modules/lambda_report"
  lambda_role_arn       = module.iam.lambda_role_arn
  lambda_suffix         = random_string.lambda_suffix.result
  sns_topic_arn         = module.sns.sns_topic_arn
  lambda_sns_policy_arn = module.iam.lambda_sns_policy_arn
}
