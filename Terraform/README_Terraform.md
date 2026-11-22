# Infrastructure as Code (Terraform) — E-Commerce Application

## 1. Overview

This directory contains the modular **Terraform** configuration used to provision and manage the AWS cloud infrastructure for the full-stack [E-Commerce Application](https://github.com/manojpandekamat/E-CommerceApp).

The infrastructure is organized into **three decoupled layers** (`network-setup`, `backend-setup`, and `frontend-setup`) utilizing reusable local child modules and the **HashiCorp AWS Provider (`v6.70.0`)**.

---

## 2. Directory & Module Structure

* **`Terraform/`**
  * **`network-setup/`** *(Layer 1: Core AWS VPC & Networking)*
    * `modules/vpc/` — Virtual Private Cloud (VPC)
    * `modules/subnet/` — Public and Private subnets across Availability Zones
    * `modules/internet-gateway/` — Internet Gateway (IGW) for public internet access
    * `modules/nat-gateway/` — NAT Gateway for outbound internet access from private subnets
    * `modules/route-table-public/` — Public route table (`0.0.0.0/0` → IGW)
    * `modules/route-table-private/` — Private route table (`0.0.0.0/0` → NAT Gateway)
    * `modules/route-table-association/` — Associates public subnets with public route tables
    * `modules/nat-route-table-association/` — Associates private subnets with private route tables
  * **`backend-setup/`** *(Layer 2: Auto-Scaled Spring Boot Backend & Load Balancing)*
    * `modules/alb/` — Application Load Balancer (ALB)
    * `modules/target-group/` — ALB Target Group with health checks
    * `modules/alb-tg-listener/` — HTTP/HTTPS Listener forwarding traffic to the target group
    * `modules/lauch-template/` — EC2 Launch Template (AMI, instance type, security groups, user data)
    * `modules/autoscaling-group/` — Auto Scaling Group (ASG) managing backend capacity
  * **`frontend-setup/`** *(Layer 3: React Frontend Infrastructure)*
    * Provisions AWS compute/hosting resources for the production React application bundle

---

## 3. Infrastructure Layers Breakdown

### Layer 1: `network-setup` (Foundational Networking)
Establishes an isolated multi-tier AWS network topology separating public load balancers from private application servers:
* **VPC & Subnets (`vpc`, `subnet`):** Segments network CIDR blocks into public and private subnets across multiple Availability Zones for high availability.
* **Public Internet Routing (`internet-gateway`, `route-table-public`, `route-table-association`):** Enables inbound and outbound internet traffic for public subnets hosting the Application Load Balancer and NAT Gateway.
* **Private Outbound Routing (`nat-gateway`, `route-table-private`, `nat-route-table-association`):** Allows backend EC2 instances in private subnets to pull updates and dependencies securely without exposing them directly to inbound internet traffic.

### Layer 2: `backend-setup` (High-Availability Backend Compute)
Deploys a fault-tolerant, horizontally scalable runtime tier for the Spring Boot backend service:
* **Application Load Balancer (`alb`, `target-group`, `alb-tg-listener`):** Distributes incoming API requests across healthy backend instances and performs automated health checks.
* **Launch Template (`lauch-template`):** Standardizes EC2 instance specifications (AMI, instance type, key pair, security groups, and bootstrap user-data scripts).
* **Auto Scaling Group (`autoscaling-group`):** Dynamically scales backend EC2 instances across private subnets and automatically replaces unhealthy instances registered with the ALB Target Group.

### Layer 3: `frontend-setup` (Frontend Infrastructure)
Provisions the AWS resources required to host the React frontend build (`frontend/build/`) and connect to the backend Application Load Balancer.

---

## 4. Prerequisites & Provider Details

* **Terraform CLI:** `v1.5+`
* **AWS Provider:** `hashicorp/aws` (`v6.70.0`)
* **AWS Authentication:** Configured via AWS CLI (`aws configure`) or environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_DEFAULT_REGION`) with permissions for VPC, EC2, ELB, Auto Scaling, and IAM.

---

## 5. Execution & Deployment Order

Because `backend-setup` and `frontend-setup` depend on the VPC and subnet IDs created by `network-setup`, initialize and apply the stacks in order:

1. **Provision Networking (`Terraform/network-setup`):**
   * Run `terraform init`
   * Run `terraform plan`
   * Run `terraform apply`
2. **Provision Backend Infrastructure (`Terraform/backend-setup`):**
   * Run `terraform init`
   * Run `terraform plan`
   * Run `terraform apply`
3. **Provision Frontend Infrastructure (`Terraform/frontend-setup`):**
   * Run `terraform init`
   * Run `terraform plan`
   * Run `terraform apply`

### Teardown Order
To avoid resource dependency errors when cleaning up infrastructure, run `terraform destroy` in reverse order:
1. `Terraform/frontend-setup`
2. `Terraform/backend-setup`
3. `Terraform/network-setup`