# Terraform AWS Sample

This is a sample Terraform project to create a VPC, Subnets, Security Groups, and ECS on Fargate in AWS.

It can also be used for learning purposes. It can also be used as an IaC environment for easy deployment in an AWS environment.

## Prerequisites

requires Terraform v1.4.4 or later.

## Usage

This project uses Taskfile to run docker and terraform commands. You can install Taskfile from [here](https://taskfile.dev/#/installation).

To certify your AWS account, you need to set your AWS credentials to environment variables. However, the credentials are not encrypted. So, you can use [aws-vault](https://github.com/99designs/aws-vault) to encrypt your credentials.

1. Build docker image to push to ECR

```bash
task build
```

2. Init terraform

```bash
task init
```

3. Plan terraform

```bash
task plan
```

4. Apply terraform

```bash
task apply
```

5. Destroy terraform

```bash
task destroy
```

## License

MIT License
