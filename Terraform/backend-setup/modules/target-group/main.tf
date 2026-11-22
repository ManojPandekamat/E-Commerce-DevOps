resource "aws_lb_target_group" "alb_tg" {
  name     = var.target_group_name
  port     = 8080 // Specify the port on which the targets receive traffic
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  # target_type defaults to instance

  health_check {
    path = "/"
  }
}