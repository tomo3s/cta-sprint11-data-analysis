data "aws_caller_identity" "current" {}

locals {
  project_name = "sales-analytics"
  account_id   = data.aws_caller_identity.current.account_id
}