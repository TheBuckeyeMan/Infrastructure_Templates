resource "aws_iam_role" "lambda_role" {
  name = "lambda_role_for_s3_access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
}

resource "aws_lambda_function" "api_lambda" {
  function_name = "api_lambda_function"
  role          = aws_iam_role.lambda_role.arn

  package_type = "Image"
  image_uri    = "${aws_ecr_repository.ecr_repo.repository_url}:latest"

  environment {
    variables = {
      AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
      AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
      AWS_REGION            = var.AWS_REGION
      Api_Key               = var.Api_Key 
    }
  }

  timeout = 15
  memory_size = 512
}

resource "aws_ecr_repository" "ecr_repo" {
  name = "youtube-containers"
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name = aws_lambda_function.api_lambda.function_name

  authorization_type = "NONE"
}