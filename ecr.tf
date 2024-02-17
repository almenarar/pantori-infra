resource "aws_ecr_repository" "backend" {
  name = "pantori-backend"

  tags = {
    Owner       = "Pantori"
    Environment = "Production"
  }
}

resource "aws_ecr_repository" "frontend" {
  name = "pantori-frontend"

  tags = {
    Owner       = "Pantori"
    Environment = "Production"
  }
}