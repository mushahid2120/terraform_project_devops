# Terraform AWS 3-Tier Architecture Deployment

This repository contains Terraform code to provision a full 3-tier architecture on AWS. It uses Terraform modules to deploy the network (VPC), compute (EC2), database (RDS), and load balancers with auto scaling in a scalable and reusable manner.


![3TierArch](https://github.com/user-attachments/assets/8bc838a0-6853-4025-a833-3fc79588d568)

---

## ⚙️ Stack Overview

- **Cloud Provider**: AWS
- **Infrastructure as Code**: Terraform
- **Architecture**: 3-Tier (Frontend, Backend, Database)
- **Features**:
  - Modular structure
  - Auto-scaling groups with ALBs
  - RDS with private subnets
  - Secure and production-ready network design

---

## 📂 Module Breakdown

### 1. **VPC Module** (`./vpc`)
- Creates the VPC and associated networking components:
  - Public & private subnets across 2 AZs
  - Internet Gateway, NAT Gateway
  - Route tables and Security Groups
- Outputs subnet IDs and VPC ID for dependency injection into other modules

### 2. **RDS Module** (`./rds`)
- Provisions a MySQL database instance
- Uses a subnet group containing private subnets
- Accepts security group from the VPC module
- Outputs the RDS endpoint

### 3. **Instance Module** (`./intance`)
- Creates EC2 instances for:
  - Public (frontend) tier
  - Private (backend) tier
- Injects RDS endpoint and security groups
- Uses `user-data.sh` scripts for provisioning

### 4. **Load Balancer Module** (`./load_balancer`)
- Creates two Application Load Balancers:
  - Public-facing ALB for frontend
  - Internal ALB for backend
- Defines listeners and target groups
- Used in conjunction with Auto Scaling

### 5. **Auto Scaling**
- Launch templates for frontend and backend EC2 instances
- Auto Scaling groups with health checks
- Automatically attach to respective ALBs

---

## 🚀 Deployment Instructions

### Prerequisites
- AWS CLI configured (`aws configure`)
- Terraform installed (`>= 1.0`)
- An existing key pair in AWS (e.g., `new-mum-key`)

### Steps

```bash
# Clone the repository
git clone https://github.com/mushahid2120/terraform_project_devops.git
cd terraform_project_devops

# Initialize the project
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply -auto-approve
```

---

## 🔙 Destroy Infrastructure

To tear down all resources:
```bash
terraform destroy -auto-approve
```

---

## 🔗 Outputs

After deployment, Terraform will output useful information such as:
- RDS endpoint
- ALB DNS names

---
