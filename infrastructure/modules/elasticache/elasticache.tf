resource "aws_elasticache_subnet_group" "redis" {
  name        = "${replace(var.name, "_", "-")}"
  subnet_ids  = ["${var.private_subnet_id}"]
  description = "${replace(var.name, "_", " ")}"
}

resource "aws_elasticache_parameter_group" "redis" {
  name        = "${replace(var.name, "_", "-")}"
  family      = "redis2.8"
  description = "${replace(var.name, "_", " ")}"
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${element(split("_", var.name), 0)}"
  engine               = "redis"
  engine_version       = "2.8.24"
  maintenance_window   = "sun:05:00-sun:06:00"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "${aws_elasticache_parameter_group.redis.id}"
  port                 = 6379
  subnet_group_name    = "${aws_elasticache_subnet_group.redis.name}"
  security_group_ids   = ["${var.security_group_id_redis}"]

  tags {
    Name = "${var.name}"
  }
}
