locals {
  cpu = 256
  memory = 512
}

# Cluster
resource "aws_ecs_cluster" "cluster" {
  name = "fargate-cluster"
}

# Service
resource "aws_ecs_service" "service" {
  name = "fargate-service"
  cluster = aws_ecs_cluster.cluster.id
  desired_count = 2
  task_definition = aws_ecs_task_definition.task_def.arn
  launch_type = "FARGATE"

  network_configuration {
    subnets = flatten([var.private_subnets])
    security_groups = [var.fargate_security_group]
    assign_public_ip = "false"
  }
}

# Task Definition
resource "aws_ecs_task_definition" "task_def" {
  family = "fargate"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = local.cpu
  memory = local.memory
  execution_role_arn = var.iam_role_arn
  container_definitions = data.template_file.task_def.rendered
}

data "aws_caller_identity" "current" {}

data "template_file" "task_def" {
  template = file("json/task_definition.json")

  vars = {
    account_id = data.aws_caller_identity.current.account_id
    aws_region = var.aws_region
    cpu = local.cpu
    memory = local.memory
    repository = "batch-repository"
    tag = "latest"
  }
}
