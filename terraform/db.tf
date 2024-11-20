# Reference the default VPC (if applicable)
data "aws_vpc" "default" {
  default = true
}

# Reference the default security group in your VPC using filters
data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id  # Fetch the default security group for the default VPC

  filter {
    name   = "group-name"
    values = ["default"]  # Ensures only the default security group is selected
  }
}

# RDS instance definition for PostgreSQL (using valid version)
resource "aws_db_instance" "free_tier_postgresql" {
  allocated_storage    = 20  # 20GB of storage (Free Tier)
  storage_type         = "gp2"  # General Purpose SSD
  instance_class       = "db.t3.micro"  # db.t3.micro (Free Tier eligible)
  engine               = "postgres"  # PostgreSQL engine
  engine_version       = "15.5"  
  username             = "postgres"  # Database admin username
  password             = "yourpassword"  # Your database password (ensure security)
  db_name              = "mydb"  # Database name
  publicly_accessible  = true  # Expose DB to the outside world
  multi_az             = false  # Free tier instances cannot be multi-AZ
  skip_final_snapshot  = true  # Skip snapshot on deletion

  # Optional backup retention and final snapshot configuration
  backup_retention_period = 7  # Retain backups for 7 days
  final_snapshot_identifier = "my-final-snapshot"

  # Attach the default security group
  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "MyFreeTierPostgresRDS"
  }
}

# Note: No need to create additional security group rules since the default security group already allows inbound/outbound traffic by default.
