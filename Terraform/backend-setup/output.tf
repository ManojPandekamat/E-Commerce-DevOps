output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "alb_security_group_id" {
  description = "Security group ID used by the ALB and allowed by the application instances"
  value       = module.alb.alb_sg_id
}

output "target_group_arn" {
  description = "ARN of the HTTP:8080 target group attached to the listener and Auto Scaling Group"
  value       = module.target_group.tg_arn
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.autoscaling_group.name
}

output "launch_template_id" {
  description = "ID of the launch template used by the Auto Scaling Group"
  value       = module.launch_template.launch_template_id
}

output "launch_template_version" {
  description = "Latest launch template version used by the Auto Scaling Group"
  value       = module.launch_template.launch_template_version
}