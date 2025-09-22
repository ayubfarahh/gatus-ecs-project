resource "aws_ecs_cluster" "gatus_cluster" {
  name = "gatus-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "ecs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_policy" {
  role       = aws_iam_role.ecs_task_execution
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_ecs_task_definition" "gatus_task" {
    family = "gatus-task-definition"
    requires_compatibilities = [ "FARGATE" ]
    network_mode = "awsvpc"
    cpu = 1024
    memory = 2048
    execution_role_arn = aws_iam_role.ecs_task_execution.arn
    container_definitions = <<TASK_DEFINITION
    [
      {
       "name": "gatus",
       "image": "940622738555.dkr.ecr.eu-west-2.amazonaws.com/gatus:latest",
       "cpu": 1024,
       "memory": 2048,
       "essential": true
      }
    ]
    TASK_DEFINITION
  
}

resource "aws_security_group" "ecs_sg" {
  name = "ecs_sg"
  vpc_id = var.vpc_id

  ingress{
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    security_groups = [ var.alb_sg ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_ecs_service" "gatus_service" {
  name            = "gatus_service"
  cluster         = aws_ecs_cluster.gatus_cluster
  task_definition = aws_ecs_task_definition.gatus_task
  desired_count   = 1

  load_balancer {
    target_group_arn = var.alb_tg_arn
    container_name   = "80"
    container_port   = 3000
  }

  network_configuration {
    subnets = var.priv_subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}