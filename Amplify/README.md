# terraform website deployment

Terraform automation for cloud

## Prereqs

* You have a Domain Name, e.g. testapp.com


## AWS

Before starting with Terraform you should have configured your credentials in the AWS folder in your system as shown below.

```aws
[default]
aws_access_key_id =
aws_secret_access_key =
[prod]
aws_access_key_id =
aws_secret_access_key =
```

### Initializing Terraform

```sh
terraform init
```

### Running Terraform

Run the following to ensure ***terraform*** will only perform the expected
actions:

```sh
terraform plan
```

Run the following to ensure ***terraform*** will only perform the expected actions with the  variables from a specific environment file

```sh
terraform plan --var-file="target-file"
```

Run the following to apply the configuration to the target aws Cloud
environment:

```sh
terraform apply
```
Run the following to apply the configuration and read variables from a specific environment file

```sh
terraform apply --var-file="target-file"
```

### Destroy Environment

```sh
terraform destroy
```


### Adding webhook url to Github

1. Once the amplify application is created, copy the webhook url from the "Build Settings" section in the AWS amplify app console. 
2. Go to your Github repo. Go to settings -> Webhooks and add a new webhook. 
3. Paste the webhook URL that was copied in the step 1 in the Payload URL text box, change the content type to application/JSON and click on add Webhook button.