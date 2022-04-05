variable "hash_key" {
  type = string
}
variable "range_key" {
  type = string
}

resource "aws_dynamodb_table" "customerstable" {
  name           = "customerslist"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key
  range_key      = var.range_key
  stream_enabled = true
  stream_view_type = "NEW_IMAGE"

  attribute {
    name = var.hash_key
    type = "S"
  }

  attribute {
    name = var.range_key
    type = "S"
  }
}

