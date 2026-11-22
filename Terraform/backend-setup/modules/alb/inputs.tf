variable "vpc_id"{
    description = "VPC ID where the ALB will be deployed"
    type        = string
}

variable "subnets" {
    description = "List of subnet IDs where the ALB will be deployed"
    type        = list(string)
}

variable "alb_name" {
    description = "Name of the Application Load Balancer"
    type        = string
}