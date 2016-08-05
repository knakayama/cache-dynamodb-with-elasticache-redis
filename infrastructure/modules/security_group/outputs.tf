output "id_lambda" {
  value = "${aws_security_group.lambda.id}"
}

output "id_redis" {
  value = "${aws_security_group.redis.id}"
}
