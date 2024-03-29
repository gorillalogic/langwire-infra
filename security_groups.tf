resource "aws_security_group" "ecs_tasks" {
  name = "${var.name}-sg-task-${var.environment}"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol = "tcp"
    from_port = var.langwire_rails_container_port
    to_port = var.langwire_rails_container_port
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = var.langwire_nodejs_container_port
    to_port = var.langwire_nodejs_container_port
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
