module "notifier-logs" {
  source              = "./logs"
  log_group_name      = "/ecs/pantori-notifier"
  log_group_retention = 1
}

module "notifier-repository" {
  source = "./image_repository"
  name   = "pantori-notifier"
  tags = {
    Name        = "pantori-notifier"
    Environment = "Production"
    Owner       = "Pantori"
  }
}

module "notifier-secrets" {
  source = "./secrets"
  name   = "pantori-notifier"
}

module "notifier-start-schedule" {
  source        = "./serverless"
  file_name     = "./serverless/code/start_ecs_task.zip"
  function_name = "pantori-notifier-start-schedule"
  role_arn      = aws_iam_role.lambda_execution.arn
  handler       = "start_ecs_task.lambda_handler"
  runtime       = "python3.8"
  env_vars = {
    "TASK_DEFINITION" : format("pantori-notifier:%s",module.notifier-compute.task_definition_revision)
  }
  is_scheduled         = true
  schedule_name        = "pantori-notifier-daily-start"
  schedule_description = "Triggers ECS task every day at 9 AM"
  schedule_expression  = "cron(0 9 * * ? *)"
  schedule_target_id   = "startEcsTask"
}

module "notifier-stop-schedule" {
  source               = "./serverless"
  file_name            = "./serverless/code/stop_ecs_task.zip"
  function_name        = "pantori-notifier-stop-schedule"
  role_arn             = aws_iam_role.lambda_execution.arn
  handler              = "stop_ecs_task.lambda_handler"
  runtime              = "python3.8"
  is_scheduled         = true
  schedule_name        = "pantori-notifier-daily-stop"
  schedule_description = "Stops ECS task every day at 9 AM"
  schedule_expression  = "cron(15 9 * * ? *)"
  schedule_target_id   = "stopEcsTask"
}

module "notifier-compute" {
  source               = "./compute"
  cluster              = aws_ecs_cluster.main.id
  role_arn             = aws_iam_role.ecs_task_execution_role.arn
  service_name         = "pantori-notifier"
  container_count      = 1
  cpu                  = 256
  memory               = 512
  image_name           = format("%s:d7887b3", module.notifier-repository.image_name)
  port                 = 80
  log_group_name       = module.notifier-logs.log_group_name
  is_web_faced         = false
  only_task_definition = true
  environment_variables = [
    {
      "name"  = "NOTIFIER_WORKER_NUM"
      "value" = "5"
    },
    {
      "name"  = "UNSPLASH_KEY"
      "value" = "key"
    }
  ]
  secrets = [
    {
      "name" : "JWT_KEY"
      "valueFrom" : format("%s:JWT_KEY::", module.notifier-secrets.secret_arn)
    },
    {
      "name" : "EMAIL_PROVIDER_EMAIL"
      "valueFrom" : format("%s:EMAIL_PROVIDER_EMAIL::", module.notifier-secrets.secret_arn)
    },
    {
      "name" : "EMAIL_PROVIDER_PASSWORD"
      "valueFrom" : format("%s:EMAIL_PROVIDER_PASSWORD::", module.notifier-secrets.secret_arn)
    },
  ]
  vpc                = aws_vpc.vpc.id
  security_group_alb = aws_security_group.alb_sg.id
  security_group_ecs = aws_security_group.ecs_sg.id
  public_subnets     = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  private_subnets    = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}