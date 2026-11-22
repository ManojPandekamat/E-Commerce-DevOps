variable "vpc_id"{
    description = "VPC ID where the ALB will be deployed"
    type        = string
}

variable "alb_arn" {
    description = "ARN of the Application Load Balancer"
    type        = string
}

variable "target_group_arn" {
    description = "ARN of the Target Group"
    type        = string
}