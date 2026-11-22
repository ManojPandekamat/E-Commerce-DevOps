output "alb_arn" {
  value = aws_alb.application_load_balancer.arn
}

output "alb_dns_name" {
  value = aws_alb.application_load_balancer.dns_name
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}