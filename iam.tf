resource "aws_iam_user" "user" {
  name = "pantori-app"
  path = "/app/"

  tags = {
    Owner = "Pantori"
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "pantori-app"
  path        = "/app/"
  description = "Pantori main app policy to access DynamoDB"

  tags = {
    Owner = "Pantori"
  }

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "specific",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:ConditionCheckItem",
          "dynamodb:PutItem",
          "dynamodb:DescribeTable",
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:UpdateItem"
        ],
        "Resource" : [
          "arn:aws:dynamodb:us-east-1:471112738977:table/pantori-goods",
          "arn:aws:dynamodb:us-east-1:471112738977:table/pantori-goods/index/*",
          "arn:aws:dynamodb:us-east-1:471112738977:table/pantori-categories",
          "arn:aws:dynamodb:us-east-1:471112738977:table/pantori-categories/index/*",
          "arn:aws:dynamodb:us-east-1:471112738977:table/pantori-users"
        ]
      },
      {
        "Sid" : "general",
        "Effect" : "Allow",
        "Action" : "dynamodb:ListTables",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}