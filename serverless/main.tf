resource "aws_lambda_function" "start_ecs_task" {
  filename         = var.file_name
  function_name    = var.function_name
  role             = var.role_arn
  handler          = var.handler
  runtime          = var.runtime
  source_code_hash = filebase64sha256(var.file_name)

  environment {
    variables = var.env_vars
  }
}

resource "aws_cloudwatch_event_rule" "schedule_rule" {
count       = var.is_scheduled ? 1 : 0
  name                = var.schedule_name
  description         = var.schedule_description
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "start_target" {
    count       = var.is_scheduled ? 1 : 0
  rule      = aws_cloudwatch_event_rule.schedule_rule[0].name
  target_id = var.schedule_target_id
  arn       = aws_lambda_function.start_ecs_task.arn
}

resource "aws_lambda_permission" "allow_eventbridge_start" {
    count       = var.is_scheduled ? 1 : 0
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start_ecs_task.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule_rule[0].arn
}
