module "frontend-logs" {
  source              = "./logs"
  log_group_name      = "/ecs/pantori-frontend"
  log_group_retention = 1
}

module "frontend-repository" {
  source = "./image_repository"
  name   = "pantori-frontend"
  tags = {
    Name        = "pantori-frontend"
    Environment = "Production"
    Owner       = "Pantori"
  }
}

module "frontend-compute" {
  source          = "./compute"
  cluster         = aws_ecs_cluster.main.id
  role_arn        = aws_iam_role.ecs_task_execution_role.arn
  service_name    = "pantori-frontend"
  container_count = 1
  cpu             = 256
  memory          = 512
  image_name      = format("%s:1caca8e", module.frontend-repository.image_name)
  port            = 80
  log_group_name  = module.frontend-logs.log_group_name
  is_web_faced    = true
  secrets = [
    {
      "name" : "UNSPLASH_KEY"
      "valueFrom" : module.api-secrets.secret_arn
    },
  ]
  vpc                = aws_vpc.vpc.id
  security_group_alb = aws_security_group.alb_sg.id
  security_group_ecs = aws_security_group.ecs_sg.id
  public_subnets     = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  private_subnets    = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}