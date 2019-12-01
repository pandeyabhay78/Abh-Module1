# alb.tf

resource "aws_alb" "main" {
  name            = "Assignement_External_ALB"
  subnets         = aws_subnet.External.*.id
  security_groups = [aws_security_group.ALB.id]
}

resource "aws_alb_target_group" "Nginx" {
  name        = "Nginx_Target_group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.Nginx.id
    type             = "forward"
  }
}

