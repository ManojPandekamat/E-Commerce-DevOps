/*
  Module wiring:
  1. The ALB module creates the public load balancer and its security group.
  2. The target-group module creates the HTTP:8080 destination in the same VPC.
  3. The listener module connects ALB:80 to that target group.
  4. The launch-template module creates instances that accept port 8080 only
     from the ALB security group.
  5. The Auto Scaling Group uses that launch template and registers its
     instances with the same target group.

  Root variables provide the VPC/subnets and application settings; module
  outputs are passed directly to the modules that consume them.
*/

module "alb" {
  source = "./modules/alb"
  vpc_id   = var.vpc_id
  subnets  = var.alb_subnets
  alb_name = var.alb_name
}

module "target_group" {
  source = "./modules/target-group"

  vpc_id            = var.vpc_id
  target_group_name = var.target_group_name
}

module "alb_tg_listener" {
  source = "./modules/alb-tg-listener"

  vpc_id           = var.vpc_id
  alb_arn          = module.alb.alb_arn
  target_group_arn = module.target_group.tg_arn
}

module "launch_template" {
  source = "./modules/lauch-template"

  instance_type = var.instance_type
  docker_image  = var.docker_image
  vpc_id        = var.vpc_id
  alb_sg_id     = module.alb.alb_sg_id
}

module "autoscaling_group" {
  source = "./modules/autoscaling-group"

  subnets                 = var.asg_subnets
  target_group_arn        = module.target_group.tg_arn
  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_version
}