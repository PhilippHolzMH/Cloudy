resource "aws_dynamodb_table" "CourtList" {
  name           = "customerslist"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "customer_input 1"
  range_key      = "customer_input 2"
  stream_enabled = true
  stream_view_type = "NEW_IMAGE"

  attribute {
    name = "customer_input 1"
    type = "S"
  }

  attribute {
    name = "customer_input 2"
    type = "S"
  }
}

