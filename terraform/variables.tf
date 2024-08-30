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

#UPDATE THE NAME OF THE BUCKET HERE FOR PROVISIONING A NEW BUCKET - IT MUST BE GLOBALLY UNIQUE
variable "bucket_name" {
  description = "New_S3_Bucket"
  type        = string
}