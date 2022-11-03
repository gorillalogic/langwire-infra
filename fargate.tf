resource "aws_ecs_cluster" "main" {
  name = "${var.name}-cluster-${var.environment}"
}

resource "aws_ecs_task_definition" "main" {
  family = "service"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = var.task_cpu
  memory = var.task_memory
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([
    {
      name = "langwire-${var.environment}"
      image = "${aws_ecr_repository.main.name}:latest"
      essential = true
      portMappings = [{
        protocol = "tcp"
        containerPort = var.langwire_container_port
        hostPort = var.langwire_container_port
      }],
    },
    {
      name = "parzu-${var.environment}"
      image = "${aws_ecr_repository.main.name}:latest"
      essential = true
      portMappings = [{
        protocol = "tcp"
        containerPort = var.parzu_container_port 
        hostPort = var.parzu_container_port
      }]
    }
  ])
}

resource "aws_ecs_service" "main" {
  name = "${var.name}-service-${var.environment}"
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 200
  launch_type = "FARGATE"
  scheduling_strategy = "REPLICA"

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    subnets = aws_subnet.public.*.id
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}
