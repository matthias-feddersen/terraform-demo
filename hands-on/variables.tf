variable "owner" {
  description = "Who is running this sandbox (stamped into generated config)."
  type        = string
}

variable "environments" {
  description = "Environment names to generate config files for (for_each demo)."
  type        = set(string)
  default     = ["dev", "staging"]
}

variable "motd_url" {
  description = "Public URL to fetch as a data source (no credentials)."
  type        = string
  default     = "https://jsonplaceholder.typicode.com/users/1"
}
