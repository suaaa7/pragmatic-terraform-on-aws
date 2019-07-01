module "iam" {
  source = "./modules/iam"
}

module "network" {
  source = "./modules/network"
}

module "ecr" {
  source = "./modules/ecr"
}

module "fargate" {
  source = "./modules/fargate"

  aws_region = var.aws_region
  iam_role_arn = module.iam.iam_role_arn
  private_subnets = module.network.private_subnets
}
