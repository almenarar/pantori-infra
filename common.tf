#------------------------------------

resource "aws_ecs_cluster" "main" {
  name = "pantori-cluster"
}

#------------------------------------

resource "aws_s3_bucket" "bucket" {
  bucket = "pantori-app"

  tags = {
    Name        = "pantori-app"
    Owner       = "Pantori"
    Environment = "Production"
  }
}
#------------------------------------

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

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_task_execution_policy" {
  name = "ecsTaskExecutionRolePolicy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "secretsmanager:GetSecretValue",
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_ecr_access" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.policy.arn
}

#---------------------------------------------------
resource "aws_iam_role" "lambda_execution" {
  name               = "lambdaExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "ecs_task_management" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}