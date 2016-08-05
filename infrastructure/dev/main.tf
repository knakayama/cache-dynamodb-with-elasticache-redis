module "iam" {
  source = "../modules/iam"

  name = "${var.name}"
}

module "network" {
  source = "../modules/network"

  vpc_cidr = "${var.vpc_cidr}"
}

module "security_group" {
  source = "../modules/security_group"

  name                      = "${var.name}"
  vpc_id                    = "${module.network.vpc_id}"
  private_subnet_cidr_block = "${module.network.private_subnet_cidr_block}"
}

module "elasticache" {
  source = "../modules/elasticache"

  name                    = "${var.name}"
  vpc_id                  = "${module.network.vpc_id}"
  private_subnet_id       = "${module.network.private_subnet_id}"
  security_group_id_redis = "${module.security_group.id_redis}"
}

module "dynamodb" {
  source = "../modules/dynamodb"

  name = "${var.name}"
}

module "cloudwatch" {
  source = "../modules/cloudwatch"

  name       = "${var.name}"
  lambda_arn = "${var.apex_function_cache_dynamodb_with_elasticache_redis}"
}
