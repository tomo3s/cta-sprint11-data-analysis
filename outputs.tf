output "bastion_public_ip" {
  value = aws_eip.bastion.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.sales_db.address
}

output "data_bucket" {
  value = aws_s3_bucket.data.bucket
}

output "athena_results_bucket" {
  value = aws_s3_bucket.athena_results.bucket
}

output "glue_job_name" {
  value = aws_glue_job.sales_etl.name
}

output "glue_crawler_name" {
  value = aws_glue_crawler.sales.name
}

output "glue_database_name" {
  value = aws_glue_catalog_database.sales.name
}

output "athena_workgroup_name" {
  value = aws_athena_workgroup.sales.name
}