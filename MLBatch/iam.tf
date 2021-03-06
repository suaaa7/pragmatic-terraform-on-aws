####################
# Lambda
####################
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
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  roles = [aws_iam_role.lambda.name]
}

####################
# Step Functions
####################
data "aws_iam_policy_document" "sfn" {
  statement {
    sid = "SFNAssumeRolePolicy"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "states.${var.region}.amazonaws.com",
        "events.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "sfn" {
  name = "sfn-role"
  assume_role_policy = data.aws_iam_policy_document.sfn.json
}

resource "aws_iam_policy_attachment" "sfn" {
  name = "AWSLambdaRole"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
  roles = [aws_iam_role.sfn.name]
}

data "aws_iam_policy_document" "sfn_for_cloudwatch" {
  statement {
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction",
      "states:StartExecution"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "sfn_for_cloudwatch" {
  name = "StartExecutionSFN"
  role = aws_iam_role.sfn.id
  policy = data.aws_iam_policy_document.sfn_for_cloudwatch.json
}
