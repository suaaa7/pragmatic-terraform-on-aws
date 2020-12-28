resource "random_string" "rds_password" {
  length  = 32
  special = false
}

resource "random_string" "github_hmac_secret_token" {
  length  = 32
  special = false
}

output "rds_password" {
  value = random_string.rds_password.result
}

output "github_hmac_secret_token" {
  value = random_string.github_hmac_secret_token.result
}
