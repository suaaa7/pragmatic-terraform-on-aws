output "alb_dns_name" {
  value = aws_lb.example.dns_name
}

output "operation_instance_id" {
  value = aws_instance.example_for_operation.id
}

output "rds_password" {
  value = random_string.rds_password.result
}

output "github_hmac_secret_token" {
  value = random_string.github_hmac_secret_token.result
}
