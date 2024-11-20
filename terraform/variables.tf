variable "db_username" {
  description = "Database username for PostgreSQL"
  type        = string
}

variable "db_password" {
  description = "Database password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name for PostgreSQL"
  type        = string
  default     = "completePostgresql"
}

variable "db_port" {
  description = "Database port"
  type        = string
  default     = "5432"
}
