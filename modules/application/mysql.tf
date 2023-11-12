# ---------------------------------------
# MySQL RDS Instance
# ---------------------------------------
resource "aws_db_instance" "example" {
    engine = "mysql"
    engine_version = "8.0.34"
    instance_class = "db.t3.micro"

    identifier = local.rds_secrets["database_name"]
    username = local.rds_secrets["master_username"]
    password = local.rds_secrets["master_password"]
    port = 3306

    # Storage size (GB)
    allocated_storage = 20
    # Storage auto-expansion size (GB)
    max_allocated_storage = 50
    # Settings for specifying the type of storage used by the AWS RDS instance
    # gp2 : General Purpose SSD(default)
    # io1 : Provisioned IOPS SSD(Storage type for workloads requiring high performance)
    # standard : Magnetic(Traditional HDD-based storage type, low cost but offers lowest performance)
    storage_type = "gp2"
    # Flag specifying whether to enable storage encryption
    storage_encrypted = false

    # Flag specifying whether to enable Multi-AZ
    multi_az = false
    availability_zone = "${data.aws_region.current.name}a"
    db_subnet_group_name = var.db_subnet_group_name
    vpc_security_group_ids = [ var.db_security_group_id ]
    # Flag specifying whether to enable public access
    publicly_accessible = false

    # This attribute is used to specify the RDS parameter group used to manage the configuration of the AWS RDS database instance.
    # A parameter group is a collection of a set of parameters that control the behavior of the database engine.
    parameter_group_name = aws_db_parameter_group.db_parameter_group.name

    
    # A collection of options that provide additional features and characteristics to the database instance.
    option_group_name = aws_db_option_group.mysql_option_group.name

    # Set the time for backup
    backup_window = "07:00-09:00"
    # Set backup retention period (days)
    backup_retention_period = 0
    # Set the time to update the engine version of the DB instance or cluster,
    # and the time to perform the update operation when there is an OS update
    maintenance_window = "sun:03:00-sun:04:00"
    # Automatically perform or configure minor DB version upgrades
    auto_minor_version_upgrade = false

    # Specifies whether the delete operation is accepted.
    # true if you don't want the operation to be deleted.
    deletion_protection = false
    # Flag specifying whether to skip the last snapshot when deleting an RDS cluster
    skip_final_snapshot = true
    # If true, changes are applied immediately. This may involve restarting the database.
    apply_immediately = true
}

# ---------------------------------------
# MySQL RDS Parameter Group
# ---------------------------------------
resource "aws_db_parameter_group" "db_parameter_group" {
  name = "${var.project}-${var.environment}-rds-cluster-parameter-group"
  family = "mysql8.0"

  parameter {
    name         = "character_set_client"
    value        = "utf8mb4"
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_connection"
    value        = "utf8mb4"
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_database"
    value        = "utf8mb4"
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_filesystem"
    value        = "utf8mb4"
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_results"
    value        = "utf8mb4"
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_server"
    value        = "utf8mb4"
    apply_method = "immediate"
  }

  parameter {
    name         = "collation_connection"
    value        = "utf8mb4_general_ci"
    apply_method = "immediate"
  }

  parameter {
    name         = "collation_server"
    value        = "utf8mb4_general_ci"
    apply_method = "immediate"
  }

  parameter {
    name = "time_zone"
    value = "Asia/Tokyo"
    apply_method = "immediate"
  }
}

#----------------------------------------
# RDS option group
#----------------------------------------
resource "aws_db_option_group" "mysql_option_group" {
  name = "${var.project}-${var.environment}-mysql-option-group"
  engine_name = "mysql"
  major_engine_version = "8.0"
}
