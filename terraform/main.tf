data "aws_ecr_image" "latest_image" {
  repository_name = "youtube-containers"
  image_tag       = "factservice"
}

data "aws_iam_role" "existing_lambda_role" {
  name = "lambda_role_for_s3_access"
}

resource "aws_lambda_function" "api_lambda" {
  function_name = "api_lambda_function"
  role          = data.aws_iam_role.existing_lambda_role.arn

  package_type = "Image"
  image_uri    = "${data.aws_ecr_image.latest_image.image_uri}"

  environment {
    variables = {
    #   AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
    #   AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
    #   AWS_REGION            = var.AWS_REGION
      Api_Key               = var.Api_Key 
    }
  }

  timeout = 15
  memory_size = 512
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name = aws_lambda_function.api_lambda.function_name

  authorization_type = "NONE"
}