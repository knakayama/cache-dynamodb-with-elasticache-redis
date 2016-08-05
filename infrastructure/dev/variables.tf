variable "aws_region" {}

variable "apex_function_cache_dynamodb_with_elasticache_redis" {}

variable "name" {
  default = "cache_dynamodb_with_elasticache_redis"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
