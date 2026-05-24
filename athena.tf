resource "aws_athena_workgroup" "sales" {
  name = "${local.project_name}-workgroup"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena_results.bucket}/results/"
    }
  }

  force_destroy = true

  tags = {
    Name = "${local.project_name}-workgroup"
  }
}