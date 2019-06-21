resource "aws_cloudwatch_event_rule" "lambda" {
  name = "every_3minute"
  schedule_expression = "cron(*/3 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule = aws_cloudwatch_event_rule.lambda.id
  target_id = "lambda"
  arn = var.apex_function_src
  # arn = "arn:aws:lambda:${var.aws_region}:${element(split(":", var.lambda_function_role_id), 4)}:function:src"
  # role_arn = aws_iam_role.lambda.arn
}

resource "aws_lambda_permission" "lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_cloudwatch_event_target.lambda.arn
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.lambda.arn
}
