resource "aws_amplify_app" "test-amplify-app" {
    name = "${var.Environment}-${var.ProjectName}-frontend"
    repository = var.CodeRepository
    access_token = var.GithubAccessToken
    build_spec = "${file("buildspec.yml")}"
    platform = "WEB"

    enable_auto_branch_creation = true
    enable_branch_auto_build = true
    enable_branch_auto_deletion = true

    auto_branch_creation_config {
      enable_pull_request_preview = true
      environment_variables = {
        APP_ENVIRONMENT = "develop"
      }
    } 

    iam_service_role_arn = aws_iam_role.amplify_role.arn

    # Comment this on the first run, trigger a build of your branch, This will added automatically on the console after deployment. Add it here to ensure your subsequent terraform runs don't break your amplify deployment.
    # custom_rule {
    #   source = "/<*>"
    #   status = "200"
    #   target = "https://develop.d1tma0emwyz6n0.amplifyapp.com/<*>" 
    # }

    custom_rule {
      source = "/<*>"
      status = "404-200"
      target = "/index.html"  
    }
  tags = {
      Environment = var.Environment
      Project     = var.ProjectName
    }

}

resource "aws_amplify_branch" "develop" {
  app_id      = aws_amplify_app.test-amplify-app.id
  enable_auto_build = true
  branch_name = var.BranchName
  //framework = "React"
  //stage     = "DEVELOPMENT"
  environment_variables = {
    APP_ENVIRONMENT = "develop"
  }
}

resource "aws_amplify_webhook" "develop" {
  app_id      = aws_amplify_app.test-amplify-app.id
  branch_name = aws_amplify_branch.develop.branch_name
  description = "trigger develop"
}


resource "null_resource" "trigger" {
  provisioner "local-exec" {
    command = "aws amplify start-job --app-id ${aws_amplify_app.test-amplify-app.id} --branch-name ${var.BranchName} --job-type RELEASE"
  }
  depends_on = [
    aws_amplify_branch.develop
  ]   
}

resource "aws_amplify_domain_association" "develop" {
  app_id      = aws_amplify_app.test-amplify-app.id
  domain_name = "${var.Domain}"

  sub_domain {
    branch_name = aws_amplify_branch.develop.branch_name
    prefix      = "${var.Environment}"
  }
}