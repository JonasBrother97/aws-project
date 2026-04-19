resource "aws_dynamodb_table" "main" {
  name         = "${local.name_prefix}-table"
  billing_mode = var.dynamodb_billing_mode
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name        = "${local.name_prefix}-table"
    Environment = var.environment
  }
}
