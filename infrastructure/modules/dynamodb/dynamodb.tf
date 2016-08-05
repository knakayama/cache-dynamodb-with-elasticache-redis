resource "aws_dynamodb_table" "dynamodb" {
  name           = "${var.name}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Word"
  range_key      = "CreatedAt"

  attribute {
    name = "Word"
    type = "S"
  }

  attribute {
    name = "CreatedAt"
    type = "N"
  }
}
