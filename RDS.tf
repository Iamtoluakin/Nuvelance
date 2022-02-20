resource "aws_db_instance" "Nuvalencedb" {

  allocated_storage       = 100 # gigabytes
  backup_retention_period = 7   # in days
  engine                  = "postgres"
  engine_version          = "12"
  identifier              = "nuvalence"
  name                    = "db_name"
  instance_class          = "db.r3.large"
  multi_az                = true
  username                = "Nuvalence_1"
  password                = "Jesusislord"
  port                    = 5432
  publicly_accessible     = true
  storage_encrypted       = true
  storage_type            = "gp2"
}