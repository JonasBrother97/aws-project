# ── SNS topic ────────────────────────────────────────────────────────────────

resource "aws_sns_topic" "main" {
  name = "${local.name_prefix}-topic"

  tags = {
    Name        = "${local.name_prefix}-topic"
    Environment = var.environment
  }
}

# ── SQS subscription ─────────────────────────────────────────────────────────

resource "aws_sns_topic_subscription" "sqs" {
  topic_arn            = aws_sns_topic.main.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.main.arn
  raw_message_delivery = true
}
