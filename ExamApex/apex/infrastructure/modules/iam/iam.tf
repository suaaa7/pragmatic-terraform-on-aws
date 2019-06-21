data "aws_iam_policy_document" "lambda" {
  statement {
    sid = "LambdaAssumeRolePolicy"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name = "lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_policy_attachment" "lambda" {
  name = "LambdaBasicExecRole"
  roles = [aws_iam_role.lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy_attachment" "cloudwatchlogs" {
  name = "CloudWatchLogsFullAccess"
  roles = [aws_iam_role.lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
