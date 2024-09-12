data "aws_ecr_image" "latest_image" {
  repository_name = "<Your ECR Repo Name Here>"
  image_tag       = "<Your Container Name Here>"
}

data "aws_iam_role" "existing_lambda_role" {
  name = "lambda_role_for_s3_access" #Change if you need a dfferent IAM Role for your Lambda
}

resource "aws_lambda_function" "api_lambda" {
  function_name = "<Add Your Lambda Name Here>"
  role          = data.aws_iam_role.existing_lambda_role.arn

  package_type = "Image"
  image_uri    = "${data.aws_ecr_image.latest_image.image_uri}"

  environment {
    variables = {
      #Add or remove all environment variables here
      Api_Key = var.Api_Key 
    }
  }

  timeout = 30 #This is the number of seconds we will alow lambda to run
  memory_size = 512 #Amount of memory we allow lambda to have
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name = aws_lambda_function.api_lambda.function_name

  authorization_type = "NONE"
}