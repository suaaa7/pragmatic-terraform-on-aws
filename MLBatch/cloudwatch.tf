resource "aws_cloudwatch_event_rule" "sfn" {
  name = "every_minute"
  schedule_expression = "cron(*/3 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "sfn" {
  rule = aws_cloudwatch_event_rule.sfn.id
  target_id = "sfn"
  arn = aws_sfn_state_machine.sfn.id
  role_arn = aws_iam_role.sfn.arn
}
