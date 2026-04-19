# ── Dead-letter queue ────────────────────────────────────────────────────────

resource "aws_sqs_queue" "dlq" {
  name                      = "${local.name_prefix}-dlq"
  message_retention_seconds = 1209600 # 14 days

  tags = {
    Name        = "${local.name_prefix}-dlq"
    Environment = var.environment
  }
}

# ── Main SQS queue ───────────────────────────────────────────────────────────

resource "aws_sqs_queue" "main" {
  name                       = "${local.name_prefix}-queue"
  visibility_timeout_seconds = var.sqs_visibility_timeout
  message_retention_seconds  = 86400

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })

  tags = {
    Name        = "${local.name_prefix}-queue"
    Environment = var.environment
  }
}

# ── Allow SNS to send messages to the SQS queue ─────────────────────────────

resource "aws_sqs_queue_policy" "main" {
  queue_url = aws_sqs_queue.main.id

  policy = data.aws_iam_policy_document.sqs_sns_send.json
}

data "aws_iam_policy_document" "sqs_sns_send" {
  statement {
    sid    = "AllowSNSPublish"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.main.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.main.arn]
    }
  }
}
