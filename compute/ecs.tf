resource "aws_ecs_task_definition" "main" {
  family                   = var.service_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.role_arn
  task_role_arn            = var.role_arn

  container_definitions = jsonencode([
    {
      name      = var.service_name
      image     = var.image_name
      essential = true
      portMappings = [
        {
          containerPort = var.port
          hostPort      = var.port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group_name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
          "awslogs-create-group" : "true",
        }
      }
      environment = var.environment_variables
      secrets     = var.secrets
    }
  ])
}

resource "aws_ecs_service" "main" {
  name            = format("%s-service", var.service_name)
  cluster         = var.cluster
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.container_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    assign_public_ip = false
    security_groups  = [var.security_group_ecs, var.security_group_alb]
  }

  dynamic "load_balancer" {
    for_each = var.is_web_faced ? [1] : []
    content {
      target_group_arn = aws_lb_target_group.main[0].arn
      container_name   = var.service_name
      container_port   = var.port
    }
  }
}