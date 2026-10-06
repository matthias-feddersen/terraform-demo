output "app_name" {
  description = "Random pet name used as the app identifier."
  value       = local.app_name
}

output "bundle_dir" {
  description = "Where generated files were written."
  value       = local.bundle_dir
}

output "config_files" {
  description = "Config path per environment."
  value       = { for env, f in local_file.config : env => f.filename }
}

output "db_password" {
  description = "Generated DB password (sensitive — use terraform output -raw db_password)."
  value       = random_password.db.result
  sensitive   = true
}

output "certificate_cn" {
  description = "Common name on the self-signed cert."
  value       = "${local.app_name}.local"
}
