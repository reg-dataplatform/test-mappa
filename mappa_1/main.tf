locals {
  resource_tags = merge(
    var.resource_tags, 
    {"Application" = var.project_name}
  )
}

data "aws_iam_user" "permission_boundary" {
  user_name = "default-ok-user"
}

module "iam_1" {
  source              = "git::https://github.com/reg-dataplatform/reg-aws-terraform-library//iam/role?ref=0.35.dev"
  providers           = {aws = aws}
  env                 = var.env
  parent_module_path  = var.project_name
  permission_boundary = data.aws_iam_user.permission_boundary.permissions_boundary
  assume_policy_path  = file(join("", [path.module, "/iam_1/lambda_role_assume_policy.json"]))
  policy_path         = file(join("", [path.module, "/iam_1/lambda_role_policy.json"]))
  resource_tags       = local.resource_tags
  module_name         = "iam_test_mappa_1"
}

module "lambda_1" {
  source                       = "git::https://github.com/reg-dataplatform/reg-aws-terraform-library//lambda/function?ref=0.35.dev"
  providers                    = {aws = aws}
  env                          = var.env
  parent_module_path           = var.project_name
  iam_role_arn                 = module.iam_1.arn
  lambda_script_source_dir     = join("", [path.module, "/lambda_1"])
  lambda_script_output_path    = join("", [path.module, "/zip_package_1/"])
  lambda_handler               = "lambda_1.lambda_handler"
  resource_tags                = local.resource_tags
  module_name                  = "lambda_test_mappa_1"
  timeout                      = 60
}

module "lambda_1_2" {
  source                       = "git::https://github.com/reg-dataplatform/reg-aws-terraform-library//lambda/function?ref=0.35.dev"
  providers                    = {aws = aws}
  env                          = var.env
  parent_module_path           = var.project_name
  iam_role_arn                 = module.iam_1.arn
  lambda_script_source_dir     = join("", [path.module, "/lambda_1"])
  lambda_script_output_path    = join("", [path.module, "/zip_package_1/"])
  lambda_handler               = "lambda_1.lambda_handler"
  resource_tags                = local.resource_tags
  module_name                  = "lambda_test_mappa_1_2"
  timeout                      = 60
}