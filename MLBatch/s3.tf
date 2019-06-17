resource "aws_s3_bucket" "bucket" {
  bucket = "ss-json-data"
  acl = "private"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_doc.json
}

data "aws_iam_policy_document" "bucket_policy_doc" {
  statement {
    effect = "Allow"
    actions = ["s3:GetObject", "s3.PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.bucket.arn}/*"]
  }
}
