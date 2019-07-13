variable "bucket_name" {}

variable "ecs_tasks_role_arn" {}

resource "aws_s3_bucket" "private" {
  bucket = var.bucket_name
  acl = "private"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket = aws_s3_bucket.private.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.private.id
  policy = data.aws_iam_policy_document.bucket.json
}

data "aws_iam_policy_document" "bucket" {
  statement {
    sid = "bucket_policy"
    effect = "Allow"
    actions = ["s3:PutObject", "s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.private.id}/*"]

    principals {
      type = "AWS"
      identifiers = [var.ecs_tasks_role_arn]
    }
  }
}
