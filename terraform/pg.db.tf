resource "aws_db_instance" "ipfs_metadata_pg" {
  identifier = "ipfs-metadata-pg"

  # PostgreSQL engine settings
  engine               = "postgres"
  engine_version       = "14"

  instance_class       = "db.t4g.micro" # Free tier eligible instance

  allocated_storage     = 20   # Free tier eligible storage
  max_allocated_storage = null # Free tier does not support storage autoscaling

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = var.db_port

  multi_az               = false # Disable Multi-AZ for Free Tier
  db_subnet_group_name   = aws_db_subnet_group.ipfs_metadata_pg_subnet_group.name
  vpc_security_group_ids = [aws_security_group.postgres_security_group.id]

  backup_retention_period = 7 # Free tier limit
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled = false # Disable to reduce costs

  tags = {
    Name = "ipfs-metadata-pg"
  }
}
