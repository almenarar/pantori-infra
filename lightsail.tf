resource "aws_lightsail_container_service" "frontend" {
  name        = "pantori-app"
  power       = "micro"
  scale       = 1
  is_disabled = false

  tags = {
    Owner       = "Pantori"
    Environment = "Production"
  }
}

resource "aws_lightsail_container_service" "backend" {
  name        = "pantori-api"
  power       = "micro"
  scale       = 1
  is_disabled = false

  tags = {
    Owner       = "Pantori"
    Environment = "Production"
  }
}