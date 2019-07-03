variable "aws_region" {
  default = "ap-northeast-1"
}

variable "project" {
  default = "batch"
}

variable "tag" {
  default = "latest"
}

module "ecs_tasks_role" {
  source = "./modules/iam"

  name = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy = data.aws_iam_policy.ecs_tasks_role_policy.policy
}

data "aws_iam_policy" "ecs_tasks_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "ecs_events_role" {
  source = "./modules/iam"

  name = "ecs-events"
  identifier = "events.amazonaws.com"
  policy = data.aws_iam_policy.ecs_events_role_policy.policy
}

data "aws_iam_policy" "ecs_events_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
}

module "network" {
  source = "./modules/network"

  project = var.project
}

module "security" {
  source = "./modules/security"

  project = var.project
  vpc = module.network.vpc
}

module "ecr" {
  source = "./modules/ecr"

  ecr_repository = var.project
}

module "fargate" {
  source = "./modules/fargate"

  aws_region = var.aws_region
  project = var.project
  ecs_tasks_role_arn = module.ecs_tasks_role.iam_role_arn
  ecs_events_role_arn = module.ecs_events_role.iam_role_arn
  private_subnets = module.network.private_subnets
  fargate_security_group = module.security.fargate_security_group
  repository_url = module.ecr.repository_url
  tag = var.tag
}
