resource "aws_lb" "this" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "${var.name}-alb"
  }
}

resource "aws_lb_target_group" "this" {
  name                          = "${var.name}-alb-target-group"
  vpc_id                        = var.vpc_id
  port                          = 80
  protocol                      = "HTTP"
  load_balancing_algorithm_type = "round_robin"

  health_check {
    enabled             = true
    port                = "80"
    interval            = 30
    protocol            = "HTTP"
    path                = "/"
    matcher             = 200
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  
  tags = {
    Name = "${var.name}-alb-target-group"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "this" {
  for_each = toset(aws_instance.web[*].id)

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = each.value
  port             = 80
}
