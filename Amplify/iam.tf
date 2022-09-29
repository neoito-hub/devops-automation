resource "aws_iam_role" "amplify_role" {
  name = "${var.ProjectName}_${var.IamRoleName}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "amplify.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  

  tags = {
    Environment = var.Environment
    Project     = var.ProjectName
  }
}

resource "aws_iam_role_policy" "amplify_role_policy" {
  name = "${var.ProjectName}_${var.IamPolicyName}"
  role = aws_iam_role.amplify_role.id

  policy = "${file("policies/amplify_role_policies.json")}"
}