#Ensure both AWS_ACCESS_KEY and AWS_SECRET_KEY Repo Secrets are properly configured in your repo for CICD Deployment
provider "aws" {
    region = "us-east-2"
    access_key  = var.aws_access_key
    secret_key  = var.aws_secret_key
}
