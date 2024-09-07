#Terraform code to configure an aws event bridge




#1 create new cloudwatch event rule - 
resource "aws_cloudwatch_event_rule" "daily_schedule" {
  name                = "<Name Of Event Bridge Event Here>"
  description         = "<Custom Desription - Describe what this event bridge will do>"
  schedule_expression = "<Show how often we want this event bridge to trigger>" #Example: "rate(1 day)" for 1 time per day
}

