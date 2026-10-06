# Follow along — peek at ../complete when you get stuck.
# After each step: terraform plan  (then apply when it looks right)

locals {
  # Step 5: point this at the pet name once random_pet exists
  # app_name   = random_pet.app.id
  # bundle_dir = "${path.module}/generated/${local.app_name}"
  bundle_dir = "${path.module}/generated/sandbox"
}

# Step 1 — random: a unique name stored in state
# resource "random_pet" "app" {
#   length    = 2
#   separator = "-"
# }

# Step 2 — random: a sensitive password
# resource "random_password" "db" {
#   length  = 16
#   special = false
# }

# Step 3 — tls: key + self-signed cert (no CA, no cloud)
# resource "tls_private_key" "app" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }
#
# resource "tls_self_signed_cert" "app" {
#   private_key_pem = tls_private_key.app.private_key_pem
#   subject {
#     common_name  = "${local.app_name}.local"
#     organization = var.owner
#   }
#   validity_period_hours = 24 * 30
#   allowed_uses          = ["key_encipherment", "digital_signature", "server_auth"]
# }

# Step 4 — http: read-only data from a public URL
# data "http" "motd" {
#   url = var.motd_url
#   request_headers = {
#     Accept = "application/json"
#   }
# }

# Step 5 — local: write one config.json per environment (for_each)
# resource "local_file" "config" {
#   for_each = var.environments
#   filename = "${local.bundle_dir}/${each.key}/config.json"
#   content = jsonencode({
#     app         = local.app_name
#     environment = each.key
#     owner       = var.owner
#     db_password = random_password.db.result
#     tls_cn      = "${local.app_name}.local"
#     motd        = jsondecode(data.http.motd.response_body)
#   })
# }

# Step 6 — local: persist cert (plain file) and key (sensitive file)
# resource "local_file" "cert" {
#   filename = "${local.bundle_dir}/tls/cert.pem"
#   content  = tls_self_signed_cert.app.cert_pem
# }
#
# resource "local_sensitive_file" "key" {
#   filename        = "${local.bundle_dir}/tls/key.pem"
#   content         = tls_private_key.app.private_key_pem
#   file_permission = "0600"
# }
