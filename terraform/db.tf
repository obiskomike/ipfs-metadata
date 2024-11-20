data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

resource "aws_db_instance" "free_tier_postgresql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  instance_class       = "db.t3.micro"
  engine               = "postgres"
  engine_version       = "15.5"
  username             = "postgres"
  password             = "yourpassword"
  db_name              = "mydb"
  publicly_accessible  = true
  multi_az             = false
  skip_final_snapshot  = true
  backup_retention_period = 7
  final_snapshot_identifier = "my-final-snapshot"
  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "MyFreeTierPostgresRDS"
  }
}
