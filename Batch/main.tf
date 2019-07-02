module "ecs_tasks_role" {
  source = "./modules/iam"

  name = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy = data.aws_iam_policy.ecs_tasks_role_policy.policy
}

data "aws_iam_policy" "ecs_tasks_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "network" {
  source = "./modules/network"
}

module "security" {
  source = "./modules/security"

  vpc = module.network.vpc
}

module "ecr" {
  source = "./modules/ecr"

  ecr_repository = "batch-repository"
}

module "fargate" {
  source = "./modules/fargate"

  aws_region = var.aws_region
  iam_role_arn = module.iam.iam_role_arn
  private_subnets = module.network.private_subnets
  fargate_security_group = module.security.fargate_security_group
  repository_url = module.ecr.repository_url
  tag = "latest"
}
