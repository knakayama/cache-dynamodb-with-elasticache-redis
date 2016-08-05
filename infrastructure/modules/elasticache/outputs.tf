output "id" {
  value = "${join(",", aws_elasticache_cluster.redis.cache_nodes.0.id)}"
}

output "address" {
  value = "${join(",", aws_elasticache_cluster.redis.cache_nodes.0.address)}"
}

output "az" {
  value = "${join(",", aws_elasticache_cluster.redis.cache_nodes.0.availability_zone)}"
}
