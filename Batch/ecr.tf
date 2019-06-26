resource "aws_ecr_repository" "ecr" {
  name = "batch-repository"
}

resource "aws_ecr_lifecycle_policy" "ecr" {
  repository = aws_ecr_repository.ecr.name

  policy = data.template_file.ecr.rendered
}

data "template_file" "ecr" {
  template = file("json/ecr_lifecycle_policy.json")
}

