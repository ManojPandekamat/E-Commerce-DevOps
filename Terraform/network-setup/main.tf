# -------------------------
# VPC : VPC Creation
#  Requires VPC Name and CIDR block as input variables
# -------------------------

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
  vpc_name       = var.vpc_name
}


# -------------------------
# Internet Gateway
# Reads the VPC ID from the VPC module outputs and creates an Internet Gateway
# -------------------------

module "internet_gateway" {
  source   = "./modules/internet-gateway"
  igw_name = var.igw_name
  vpc_id   = module.vpc.vpc_id
}


# -------------------------
# Public Subnet 1
# -------------------------

module "public_subnet_1" {
  source = "./modules/subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.subnets_cidrs[0]
  availability_zone = var.availability_zones[0]
  subnet_name       = var.subnet_names[0]
}


# -------------------------
# Public Subnet 2
# -------------------------

module "public_subnet_2" {
  source = "./modules/subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.subnets_cidrs[1]
  availability_zone = var.availability_zones[1]
  subnet_name       = var.subnet_names[1]
}


# -------------------------
# Private Subnet 1
# -------------------------

module "private_subnet_1" {
  source = "./modules/subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.subnets_cidrs[2]
  availability_zone = var.availability_zones[0]
  subnet_name       = var.subnet_names[2]
}


# -------------------------
# Private Subnet 2
# -------------------------

module "private_subnet_2" {
  source = "./modules/subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.subnets_cidrs[3]
  availability_zone = var.availability_zones[1]
  subnet_name       = var.subnet_names[3]
}

module "nat_gateway" {
  source = "./modules/nat-gateway"

  pubic_subnet_for_nat = module.public_subnet_1.subnet_id
  nat_gateway_name = "backend-nat-gateway"
}

# -------------------------
# Public Route Table
# -------------------------

module "public_route_table" {
  source = "./modules/route-table-public"

  vpc_id           = module.vpc.vpc_id
  igw_id           = module.internet_gateway.igw_id
  route_table_name = var.public_route_table_name
}


# -------------------------
# Private Route Table
# -------------------------

module "private_route_table" {
  source = "./modules/route-table-private"

  vpc_id           = module.vpc.vpc_id
  route_table_name = var.private_route_table_name
}


# -------------------------
# Public Subnet Associations
# -------------------------

module "public_subnet_1_association" {
  source = "./modules/route-table-association"

  subnet_id      = module.public_subnet_1.subnet_id
  route_table_id = module.public_route_table.route_table_id
}

module "public_subnet_2_association" {
  source = "./modules/route-table-association"

  subnet_id      = module.public_subnet_2.subnet_id
  route_table_id = module.public_route_table.route_table_id
}


# -------------------------
# Private Subnet Associations
# -------------------------

module "private_subnet_1_association" {
  source = "./modules/route-table-association"

  subnet_id      = module.private_subnet_1.subnet_id
  route_table_id = module.private_route_table.route_table_id
 
}

module "private_subnet_2_association" {
  source = "./modules/route-table-association"

  subnet_id      = module.private_subnet_2.subnet_id
  route_table_id = module.private_route_table.route_table_id
}

# -------------------------
# NAT Gateway Route Table Association
# -------------------------
module "nat_gateway_association" {
  source = "./modules/nat-route-table-association"

  subnet_id      = module.private_subnet_1.subnet_id
  route_table_id = module.private_route_table.route_table_id
  nat_gateway_id = module.nat_gateway.nat-gateway-id
}