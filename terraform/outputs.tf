output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name (use as your application URL)."
  value       = aws_cloudfront_distribution.static.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID."
  value       = aws_cloudfront_distribution.static.id
}

output "s3_static_bucket" {
  description = "Name of the S3 bucket that holds static assets."
  value       = aws_s3_bucket.static.bucket
}

output "s3_lambda_artifacts_bucket" {
  description = "Name of the S3 bucket used for Lambda deployment packages."
  value       = aws_s3_bucket.lambda_artifacts.bucket
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table."
  value       = aws_dynamodb_table.main.name
}

output "sqs_queue_url" {
  description = "URL of the main SQS queue."
  value       = aws_sqs_queue.main.url
}

output "sqs_dlq_url" {
  description = "URL of the dead-letter SQS queue."
  value       = aws_sqs_queue.dlq.url
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic."
  value       = aws_sns_topic.main.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.main.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function."
  value       = aws_lambda_function.main.arn
}
