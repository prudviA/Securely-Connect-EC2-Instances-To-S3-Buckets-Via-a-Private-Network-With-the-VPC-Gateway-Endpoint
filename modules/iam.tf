# creating iam role for ec2 & s3
resource "aws_iam_role" "s3_role" {
  name = "s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_policy" "s3_policy" {
  name        = "s3_policy"
  

  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3.*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_attachment" {
  role        = aws_iam_role.s3_role.name
  policy_arn    = aws_iam_policy.s3_policy
}

resource "aws_iam_instance_profile" "s3_profile" {
  name       = "s3_profile"
  role     = aws_iam_role.s3_role.name
}
