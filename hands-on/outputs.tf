# Uncomment as you add matching resources in main.tf
#
# output "app_name" {
#   value = local.app_name
# }
#
# output "bundle_dir" {
#   value = local.bundle_dir
# }
#
# output "config_files" {
#   value = { for env, f in local_file.config : env => f.filename }
# }
#
# output "db_password" {
#   value     = random_password.db.result
#   sensitive = true
# }
