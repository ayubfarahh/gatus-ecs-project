resource "aws_ecs_cluster" "gatus_cluster" {
  name = "gatus-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "gatus_task" {
    
  
}