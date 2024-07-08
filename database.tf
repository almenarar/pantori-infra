#------------------------------------

resource "aws_dynamodb_table" "goods" {
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
    name = "Name"
    type = "S"
  }

  global_secondary_index {
    name            = "WorkspaceIndex"
    hash_key        = "Workspace"
    range_key       = "Name"
    write_capacity  = 5
    read_capacity   = 5
    projection_type = "ALL"
  }

  tags = {
    Name        = "pantori-goods"
    Environment = "Production"
    Owner       = "Pantori"
  }
}

#------------------------------------

resource "aws_dynamodb_table" "categories" {
  name           = "pantori-categories"
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
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
    name = "Name"
    type = "S"
  }

  global_secondary_index {
    name            = "WorkspaceIndex"
    hash_key        = "Workspace"
    range_key       = "Name"
    write_capacity  = 2
    read_capacity   = 2
    projection_type = "ALL"
  }

  tags = {
    Name        = "pantori-goods"
    Environment = "Production"
    Owner       = "Pantori"
  }
}

#------------------------------------

resource "aws_dynamodb_table" "users" {
  name           = "pantori-users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "Username"

  attribute {
    name = "Username"
    type = "S"
  }

  tags = {
    Name        = "pantori-goods"
    Environment = "Production"
    Owner       = "Pantori"
  }
}