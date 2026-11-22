resource "aws_autoscaling_group" "app" {
  name = "app-asg"

  min_size         = 2
  desired_capacity = 2
  max_size         = 4

  vpc_zone_identifier = var.subnets

  target_group_arns = [
    var.target_group_arn
  ]

  health_check_type = "ELB"

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }
  }
}