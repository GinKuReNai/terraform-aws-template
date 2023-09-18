# ---------------------------------------
# RDS Cluster
# ---------------------------------------
resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier = "${var.project}-${var.environment}-rds-cluster"
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = var.db_security_group_id
  # If using Amazon Aurora, select "aurora-mysql"
  engine = "aurora-mysql"
  # <mysql-major-version>.mysql_aurora.<aurora-mysql-version>
  engine_version = "8.0.mysql_aurora.3.01.0"
  port = 3306

  database_name = local.rds_secrets["database_name"]
  master_username = local.rds_secrets["master_username"]
  master_password = local.rds_secrets["master_password"]

  # Flag specifying whether to skip the last snapshot when deleting an RDS cluster
  # In the case of false, once the cluster is deleted, the data is unrecoverable.
  skip_final_snapshot = true
  
  # If true, changes are applied immediately. This may involve restarting the database.
  # If false, the change will wait until the next scheduled maintenance window.
  apply_immediately = true

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.rds_cluster_parameter_group.name
}

# ---------------------------------------
# RDS Parameter Group per cluster
# ---------------------------------------
resource "aws_rds_cluster_parameter_group" "rds_cluster_parameter_group" {
  name = "${var.project}-${var.environment}-rds-cluster-parameter-group"
  family = "aurora-mysql8.0"

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

# ---------------------------------------
# RDS Cluster Instance
# ---------------------------------------
resource "aws_rds_cluster_instance" "rds_cluster_instance" {
  # Launch one Writer instance and two Reader instances for a total of three
  count = 3

  instance_class = "db.t3.small"

  identifier = "${var.project}-${var.environment}-rds-cluster-instance-${count.index}"
  # Set the same value as the cluster
  cluster_identifier = aws_rds_cluster.rds_cluster.id
  engine = aws_rds_cluster.rds_cluster.engine
  engine_version = aws_rds_cluster.rds_cluster.engine_version
  db_subnet_group_name = aws_rds_cluster.rds_cluster.db_subnet_group_name

  # Enable enhanced monitoring
  monitoring_role_arn = var.rds_monitoring_role_arn
  monitoring_interval = 60

  publicly_accessible = false
}

resource "aws_db_parameter_group" "db_parameter_group" {
  name = "${var.project}-${var.environment}-db-parameter-group"
  family = "aurora-mysql8.0"
}
