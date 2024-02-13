resource "aws_dynamodb_table" "table" {
  name           = "pantori-goods"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "ID"
  range_key      = "Workspace"

  attribute {
    name = "ID"
    type = "S"
  }

  attribute {
    name = "Workspace"
    type = "S"
  }

  attribute {
    name = "Category"
    type = "S"
  }

  global_secondary_index {
    name               = "WorkspaceIndex"
    hash_key           = "Workspace"
    range_key          = "Category"
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "ALL"
  }

  tags = {
    Name        = "pantori-goods"
    Environment = "Production"
    Owner       = "Pantori"
  }
}