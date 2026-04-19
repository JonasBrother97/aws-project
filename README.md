# aws-project

Minimal Terraform infrastructure for an AWS application that uses:

| Service | Purpose |
|---|---|
| **AWS Lambda** | Event-driven compute, triggered by SQS messages |
| **Amazon SQS** | Message queue that decouples producers from Lambda; includes a dead-letter queue |
| **Amazon SNS** | Pub/Sub topic; fans out to the SQS queue (and any other subscriber you add) |
| **Amazon DynamoDB** | Serverless NoSQL table; Lambda writes processed records here |
| **Amazon S3** | Static asset hosting (behind CloudFront) + Lambda deployment-package storage |
| **Amazon CloudFront** | CDN / HTTPS endpoint in front of the S3 static-asset bucket |

---

## Repository layout

```
aws-project/
├── lambda/
│   └── handler.py       # Minimal Lambda handler – replace with your logic
└── terraform/
    ├── versions.tf      # Terraform + provider version constraints
    ├── variables.tf     # Input variables with sensible defaults
    ├── s3.tf            # S3 buckets (static assets + Lambda artifacts)
    ├── cloudfront.tf    # CloudFront distribution + OAC bucket policy
    ├── dynamodb.tf      # DynamoDB table (PAY_PER_REQUEST by default)
    ├── sqs.tf           # SQS main queue + dead-letter queue
    ├── sns.tf           # SNS topic + SQS subscription
    ├── lambda.tf        # Lambda function, IAM role/policy, SQS trigger
    └── outputs.tf       # Useful output values
```

---

## Prerequisites

* [Terraform >= 1.3](https://developer.hashicorp.com/terraform/install)
* AWS credentials configured (`aws configure`, environment variables, or an IAM instance profile)
* S3 bucket names must be globally unique – set `project_name` and `environment` to something unique to your account

---

## Quick start

```bash
cd terraform

# 1. Initialise providers
terraform init

# 2. Review the plan (optional but recommended)
terraform plan -var="project_name=myapp" -var="environment=dev"

# 3. Deploy
terraform apply -var="project_name=myapp" -var="environment=dev"
```

After `apply` completes, Terraform prints the CloudFront domain name and all other
resource identifiers as outputs.

---

## Variables

| Name | Default | Description |
|---|---|---|
| `aws_region` | `us-east-1` | AWS region |
| `project_name` | `aws-project` | Prefix for every resource name |
| `environment` | `dev` | Deployment stage |
| `dynamodb_billing_mode` | `PAY_PER_REQUEST` | DynamoDB capacity mode |
| `lambda_runtime` | `python3.12` | Lambda runtime |
| `lambda_timeout` | `30` | Lambda timeout (seconds) |
| `lambda_memory_size` | `128` | Lambda memory (MB) |
| `sqs_visibility_timeout` | `60` | SQS visibility timeout (seconds) |

---

## Tear down

```bash
terraform destroy -var="project_name=myapp" -var="environment=dev"
```

> **Note** – both S3 buckets are created with `force_destroy = true` so Terraform
> can delete them even if they contain objects.
