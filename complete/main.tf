locals {
  app_name   = random_pet.app.id
  bundle_dir = "${path.module}/generated/${local.app_name}"
}

# Unique name stored in state. Destroy + apply gives a new pet.
resource "random_pet" "app" {
  length    = 2
  separator = "-"
}

# Sensitive value: Terraform stores it in state, hides it in CLI output.
resource "random_password" "db" {
  length  = 16
  special = false
}

# Infra-like artifact with no cloud: a keypair + self-signed cert.
resource "tls_private_key" "app" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "app" {
  private_key_pem = tls_private_key.app.private_key_pem

  subject {
    common_name  = "${local.app_name}.local"
    organization = var.owner
  }

  validity_period_hours = 24 * 30
  allowed_uses          = ["key_encipherment", "digital_signature", "server_auth"]
}

# Read-only data source: pull JSON from the public internet.
data "http" "motd" {
  url = var.motd_url

  request_headers = {
    Accept = "application/json"
  }
}

# One config file per environment (for_each + templatefile).
resource "local_file" "config" {
  for_each = var.environments

  filename = "${local.bundle_dir}/${each.key}/config.json"
  content = jsonencode({
    app         = local.app_name
    environment = each.key
    owner       = var.owner
    db_password = random_password.db.result
    tls_cn      = "${local.app_name}.local"
    motd        = jsondecode(data.http.motd.response_body)
  })
}

resource "local_file" "cert" {
  filename = "${local.bundle_dir}/tls/cert.pem"
  content  = tls_self_signed_cert.app.cert_pem
}

resource "local_sensitive_file" "key" {
  filename        = "${local.bundle_dir}/tls/key.pem"
  content         = tls_private_key.app.private_key_pem
  file_permission = "0600"
}
