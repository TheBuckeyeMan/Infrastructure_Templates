variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "region" {
    description = "Desired Region"
    type = string
    default = "us-east-2"
}

# variable "AWS_ACCESS_KEY_ID" {
#   description = "Aws Access Key"
#   type = string
# }

# variable "AWS_SECRET_ACCESS_KEY" {
#   description = "AWS Secret Access Key"
#   type = string
# }

# variable "AWS_REGION" {
#   description = "Aws Region"
#   type = string
# }

variable "Api_Key" {
  description = "Aws Region"
  type = string
}
