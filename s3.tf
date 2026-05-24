resource "aws_s3_bucket" "data" {
  bucket        = "${local.project_name}-data-${local.account_id}"
  force_destroy = true

  tags = {
    Name = "${local.project_name}-data"
  }
}

resource "aws_s3_bucket" "athena_results" {
  bucket        = "${local.project_name}-athena-results-${local.account_id}"
  force_destroy = true

  tags = {
    Name = "${local.project_name}-athena-results"
  }
}

resource "aws_s3_object" "glue_script" {
  bucket = aws_s3_bucket.data.id
  key    = "scripts/etl_sales.py"
  source = "${path.module}/scripts/etl_sales.py"
  etag   = filemd5("${path.module}/scripts/etl_sales.py")
}