output "aws_amplify_id" {
    value = aws_amplify_app.test-amplify-app.id
}

output "aws_amplify_branch_id" {
    value = aws_amplify_branch.develop.arn
}

output "aws_iam_role_id" {
    value = aws_iam_role.amplify_role.arn
}


output "aws_amplify_domain_association" {
    value = aws_amplify_domain_association.develop.domain_name
}
