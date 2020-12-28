resource "random_string" "rds_password" {
  length  = 32
  special = false
}

resource "random_string" "github_hmac_secret_token" {
  length  = 32
  special = false
}
