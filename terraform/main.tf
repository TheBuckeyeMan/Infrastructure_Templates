data "aws_ecr_image" "latest_image" {
  repository_name = "youtube-containers"
  image_tag       = "factservice"
}

data "aws_iam_role" "existing_lambda_role" {
  name = "lambda_role_for_s3_access"
}

resource "aws_lambda_function" "api_lambda" {
  function_name = "fact-service"
  role          = data.aws_iam_role.existing_lambda_role.arn

  package_type = "Image"
  image_uri    = "${data.aws_ecr_image.latest_image.image_uri}"

  environment {
    variables = {
      Api_Key = var.Api_Key 
    }
  }

  timeout = 30 #This is the number of seconds we will alow lambda
  memory_size = 512
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name = aws_lambda_function.api_lambda.function_name

  authorization_type = "NONE"
}


#IF USING EVENT BRIDGE TO TRIGGER LAMBDA

#get event bridge rule for lambda - IF ALREADY EXISTS
#IMPORT EVENT BRIDGE RULE
data "aws_cloudwatch_event_rule" "existing_event_rule" {
  name = "DailyEventBridgeTrigger"  # This should match the name of the EventBridge rule from the other repo
}

#ASSOCIATE LAMBDA WITH EVENT BRIDGE
#Utilize existing event bridge rule to trigger lambda 1 time per day
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = data.aws_cloudwatch_event_rule.existing_event_rule.name  # Reference the existing rule
  arn       = aws_lambda_function.api_lambda.arn
}

#PERMISSIONS
#Giving permission for event bridge to invoke the lambda function
# Permission for EventBridge to invoke the Lambda function
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = data.aws_cloudwatch_event_rule.existing_event_rule.arn
}






