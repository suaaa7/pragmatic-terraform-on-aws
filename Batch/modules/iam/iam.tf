resource "aws_iam_role" "ecs_task_execution" {
  name = "ecs-task-execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_role.json
}

data "aws_iam_policy_document" "ecs_tasks_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    effect = "Allow"
  }
}

/*
resource "aws_iam_policy" "ecs_task_execution" {
  name = "ecs-task-execution"
  policy = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
*/

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role = aws_iam_role.ecs_task_execution.name
  #policy_arn = aws_iam_policy.ecs_task_execution.arn
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

output "iam_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}
