variable "subnets" {
  description = "List of subnet IDs where the ASG instances will be deployed"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group to attach to the Auto Scaling Group"
  type        = string
}

variable "launch_template_id" {
  description = "ID of the launch template to use for the Auto Scaling Group"
  type        = string
}

variable "launch_template_version" {
  description = "Version of the launch template to use for the Auto Scaling Group"
  type        = number
}