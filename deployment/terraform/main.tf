provider "aws" {
  region = "us-east-1"
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
  source                 = "./modules/lambda_iam"
  lambda_role_arn        = module.iam.lambda_role_arn # ✅ Pass IAM role ARN
  sns_topic_arn          = module.sns.sns_topic_arn
  security_report_bucket = "security-scanner-reports"
}

module "lambda_report" {
  source                = "./modules/lambda_report"
  lambda_role_arn       = module.iam.lambda_role_arn
  sns_topic_arn         = module.sns.sns_topic_arn
  lambda_sns_policy_arn = module.iam.lambda_sns_policy_arn
}
