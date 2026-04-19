variable "aws_region" {
  description = "AWS region where all resources will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Short name used as a prefix for every resource."
  type        = string
  default     = "aws-project"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod, …)."
  type        = string
  default     = "dev"
}

variable "dynamodb_billing_mode" {
  description = "DynamoDB billing mode: PAY_PER_REQUEST or PROVISIONED."
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "lambda_runtime" {
  description = "Lambda function runtime."
  type        = string
  default     = "python3.12"
}

variable "lambda_timeout" {
  description = "Lambda function timeout in seconds."
  type        = number
  default     = 30
}

variable "lambda_memory_size" {
  description = "Lambda function memory in MB."
  type        = number
  default     = 128
}

variable "sqs_visibility_timeout" {
  description = "SQS message visibility timeout in seconds (should be >= Lambda timeout)."
  type        = number
  default     = 60
}
