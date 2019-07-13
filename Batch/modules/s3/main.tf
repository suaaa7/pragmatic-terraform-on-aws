variable "bucket_name" {}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl = "private"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_doc.json
}

data "aws_iam_policy_document" "" {
  statement {
    sid = "bucket_policy"
    effect = "Allow"
    actions = ["s3:PutObject", "s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"]

    principals {
      type = "AWS"
      identifiers = ["${aws_iam_role.lambda.arn}"]
    }
  }
}
