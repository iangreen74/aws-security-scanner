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

module "lambda" {
  source          = "./modules/lambda"
  lambda_role_arn = module.iam.lambda_role_arn # ✅ This now correctly references the IAM module output
  lambda_package  = "my-code.zip"
  sns_topic_arn   = module.sns.sns_topic_arn
}
