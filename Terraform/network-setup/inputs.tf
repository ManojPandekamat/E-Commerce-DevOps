variable "vpc_cidr_block" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "subnets_cidrs" {
  type = list(string)
  # ([0]- public-subnet-1, [1]- public-subnet-2, [2]- private-subnet-1, [3]- private-subnet-2)
}

variable "subnet_names" {
  type = list(string)
  # ([0]- public-subnet-1, [1]- public-subnet-2, [2]- private-subnet-1, [3]- private-subnet-2)
}

variable "availability_zones" {
  type = list(string)
  # ([0] - az-1, [1] - az-2)
}

variable "public_route_table_name" {
  type = string
}

variable "private_route_table_name" {
  type = string
}