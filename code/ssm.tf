resource "aws_ssm_parameter" "db_username" {
  name        = "/db/username"
  value       = "root"
  type        = "String"
  description = "DB User Name"
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  value       = "uninitialized"
  type        = "SecureString"
  description = "DB Password"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "github_personal_access_token" {
  name        = "github-personal-access-token"
  value       = "hoge"
  type        = "String"
  description = "GitHub Personal Access Token"
}
