resource "aws_s3_bucket" "alb_log" {
  bucket        = "alb-log-pragmatic-terraform-1621"
  force_destroy = true

  lifecycle_rule {
    enabled = true

    expiration {
      days = "30"
    }
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_elb_service_account" "alb_log" {}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.alb_log.id]
    }
  }
}

resource "aws_s3_bucket" "artifact" {
  bucket        = "artifact-pragmatic-terraform-1621"
  force_destroy = true

  lifecycle_rule {
    enabled = true

    expiration {
      days = "30"
    }
  }
}

resource "aws_s3_bucket" "operation" {
  bucket        = "operation-pragmatic-terraform-1621"
  force_destroy = true

  lifecycle_rule {
    enabled = true

    expiration {
      days = "30"
    }
  }
}

resource "aws_s3_bucket" "cloudwatch_logs" {
  bucket        = "cloudwatch-logs-pragmatic-terraform-1621"
  force_destroy = true

  lifecycle_rule {
    enabled = true

    expiration {
      days = "30"
    }
  }
}
