locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# ── S3 bucket for static website assets ─────────────────────────────────────

resource "aws_s3_bucket" "static" {
  bucket        = "${local.name_prefix}-static"
  force_destroy = true

  tags = {
    Name        = "${local.name_prefix}-static"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "static" {
  bucket = aws_s3_bucket.static.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "static" {
  bucket = aws_s3_bucket.static.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ── S3 bucket for Lambda deployment packages ────────────────────────────────

resource "aws_s3_bucket" "lambda_artifacts" {
  bucket        = "${local.name_prefix}-lambda-artifacts"
  force_destroy = true

  tags = {
    Name        = "${local.name_prefix}-lambda-artifacts"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "lambda_artifacts" {
  bucket = aws_s3_bucket.lambda_artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
