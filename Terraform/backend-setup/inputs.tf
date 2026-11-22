variable "aws_region" {
  description = "AWS region in which to create the infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID shared by the ALB, target group, and application instances"
  type        = string
}

variable "alb_subnets" {
  description = "Public subnet IDs in at least two Availability Zones for the internet-facing ALB"
  type        = list(string)
}

variable "asg_subnets" {
  description = "Subnet IDs for the Auto Scaling Group instances; ensure they have outbound access to pull the Docker image"
  type        = list(string)
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group receiving HTTP traffic on port 8080"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for application instances"
  type        = string
}

variable "docker_image" {
  description = "Docker image URI to run on each application instance"
  type        = string
}