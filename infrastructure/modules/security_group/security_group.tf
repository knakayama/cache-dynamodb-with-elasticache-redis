resource "aws_security_group" "lambda" {
  name        = "${var.name}-lambda"
  vpc_id      = "${var.vpc_id}"
  description = "${replace(var.name, "_", " ")}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}-lambda"
  }
}

resource "aws_security_group" "redis" {
  name        = "${var.name}-redis"
  vpc_id      = "${var.vpc_id}"
  description = "${replace(var.name, "_", " ")}"

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = ["${aws_security_group.lambda.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}-redis"
  }
}
