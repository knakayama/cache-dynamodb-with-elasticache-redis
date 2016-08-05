output "lambda_function_role_id" {
  value = "${module.iam.lambda_function_role_id}"
}

output "table_name" {
  value = "${module.dynamodb.table_name}"
}

output "cache_node_id" {
  value = "${module.elasticache.id}"
}

output "cache_node_address" {
  value = "${module.elasticache.address}"
}

output "az" {
  value = "${module.elasticache.az}"
}

output "private_subnet_id" {
  value = "${module.network.private_subnet_id}"
}

output "vpc_id" {
  value = "${module.network.vpc_id}"
}

output "security_group_id_lambda" {
  value = "${module.security_group.id_lambda}"
}
