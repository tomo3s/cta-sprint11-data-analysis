resource "aws_glue_connection" "rds" {
  name = "${local.project_name}-rds-connection"

  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://${aws_db_instance.sales_db.address}:3306/${aws_db_instance.sales_db.db_name}"
    USERNAME            = var.db_username
    PASSWORD            = var.db_password
  }

  physical_connection_requirements {
    availability_zone      = aws_subnet.private_1.availability_zone
    security_group_id_list = [aws_security_group.glue_sg.id]
    subnet_id              = aws_subnet.private_1.id
  }
}

resource "aws_glue_job" "sales_etl" {
  name     = "${local.project_name}-etl-job"
  role_arn = aws_iam_role.glue_role.arn

  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = 2
  timeout           = 10

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_bucket.data.bucket}/${aws_s3_object.glue_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--JOB_NAME"                         = "${local.project_name}-etl-job"
    "--S3_OUTPUT_PATH"                   = "s3://${aws_s3_bucket.data.bucket}/parquet/sales/"
    "--job-language"                     = "python"
    "--enable-continuous-cloudwatch-log" = "true"
  }

  connections = [
    aws_glue_connection.rds.name
  ]

  depends_on = [
    aws_s3_object.glue_script,
    aws_vpc_endpoint.s3
  ]
}

resource "aws_glue_catalog_database" "sales" {
  name = "sales_analytics_db"
}

resource "aws_glue_crawler" "sales" {
  name          = "${local.project_name}-crawler"
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.sales.name

  s3_target {
    path = "s3://${aws_s3_bucket.data.bucket}/parquet/sales/"
  }

  schema_change_policy {
    update_behavior = "UPDATE_IN_DATABASE"
    delete_behavior = "LOG"
  }

  tags = {
    Name = "${local.project_name}-crawler"
  }
}