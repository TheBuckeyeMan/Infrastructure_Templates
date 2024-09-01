resource "aws_iam_role" "s3_role" {
  name = "S3" #Can change the name of the IAM role if requested

  # Define the trust relationship
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = [
            "lambda.amazonaws.com",
            "ec2.amazonaws.com",
            "ecs-tasks.amazonaws.com"
          ] # Add additional compute resource types if you want other services to assume this s3 role
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy" "s3_policy" {
  name   = "S3FullAccessPolicy"
  role   = aws_iam_role.s3_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:*"  # This gives full S3 access, including create, delete, list, get, put, etc.
        ],
        Resource = "*"
      }
    ]
  })
}