resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/example"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "for_ecs_scheduled_tasks" {
  name              = "/ecs-scheduled-tasks/example"
  retention_in_days = 30
}

resource "aws_cloudwatch_event_rule" "example_batch" {
  name                = "example-batch"
  description         = "Example Batch"
  schedule_expression = "cron(0/2 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "example_batch" {
  target_id = "example-batch"
  rule      = aws_cloudwatch_event_rule.example_batch.name
  role_arn  = module.ecs_events_role.iam_role_arn
  arn       = aws_ecs_cluster.example.arn

  ecs_target {
    launch_type         = "FARGATE"
    task_count          = 1
    platform_version    = "1.4.0"
    task_definition_arn = aws_ecs_task_definition.example_batch.arn

    network_configuration {
      assign_public_ip = false
      subnets          = [aws_subnet.private_0.id]
    }
  }
}

resource "aws_cloudwatch_log_group" "operation" {
  name              = "/operation"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_subscription_filter" "example" {
  name            = "example"
  log_group_name  = aws_cloudwatch_log_group.for_ecs_scheduled_tasks.name
  destination_arn = aws_kinesis_firehose_delivery_stream.example.arn
  filter_pattern  = "[]"
  role_arn        = module.cloudwatch_logs_role.iam_role_arn
}
