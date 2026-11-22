variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "docker_image" {
  type=string
}


variable "vpc_id" {
  description = "VPC ID where the EC2 instances will be deployed"
  type        = string
}


variable "alb_sg_id" {
  description = "Security Group ID for the ALB"
  type        = string
}