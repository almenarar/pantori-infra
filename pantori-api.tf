module "api-logs" {
  source              = "./logs"
  log_group_name      = "/ecs/pantori-api"
  log_group_retention = 1
}

module "api-repository" {
  source = "./image_repository"
  name   = "pantori-api"
  tags = {
    Name        = "pantori-api"
    Environment = "Production"
    Owner       = "Pantori"
  }
}

module "api-secrets" {
  source = "./secrets"
  name   = "pantori-api-2"
}

module "api-compute" {
  source          = "./compute"
  cluster         = aws_ecs_cluster.main.id
  role_arn        = aws_iam_role.ecs_task_execution_role.arn
  service_name    = "pantori-api"
  container_count = 1
  cpu             = 256
  memory          = 512
  image_name      = format("%s:a321766", module.api-repository.image_name)
  port            = 8800
  environment_variables = [
    {
      "name"  = "GIN_MODE"
      "value" = "release"
    }
  ]
  secrets = [
    {
      "name" : "UNSPLASH_KEY"
      "valueFrom" : format("%s:UNSPLASH_KEY::", module.api-secrets.secret_arn)
    },
    {
      "name" : "JWT_KEY"
      "valueFrom" : format("%s:JWT_KEY::", module.api-secrets.secret_arn)
    },
  ]
  log_group_name     = module.api-logs.log_group_name
  is_web_faced       = true
  vpc                = aws_vpc.vpc.id
  security_group_alb = aws_security_group.alb_sg.id
  security_group_ecs = aws_security_group.ecs_sg.id
  public_subnets     = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  private_subnets    = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}