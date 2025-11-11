🚀 Terraform AWS VPC Module

This Terraform module provisions a complete AWS VPC setup including public, private, and database subnets with Internet and NAT gateways.
It’s designed for multi-environment deployments (e.g. dev, stage, prod) with consistent tagging and naming conventions.

🏗️ Features

Creates a VPC with DNS hostnames enabled

Supports multiple Availability Zones (multi-AZ)

Creates public, private, and database subnets

Public subnets connect to the Internet Gateway

Private and database subnets route through NAT Gateway

Consistent tagging with project_name, environment, and Terraform=true

🧩 Module Structure
.
├── main.tf            # Core resources: VPC, subnets, routes, NAT, IGW
├── variables.tf       # Input variables
├── outputs.tf         # Exported values
├── locals.tf          # Common naming and tagging logic
└── README.md          # Documentation (this file)

🧠 Usage Example
module "vpc" {
  source = "../path_to_module"

  project_name = "roboshop"
  environment  = "dev"
  vpc_cidr     = "10.0.0.0/16"

  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]
  database_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]

  vpc_tags = {
    Owner = "Sri Yuva Teja"
  }

  igw_tags = {
    Purpose = "Internet Access"
  }

  eip_tags = {
    Name = "NAT-EIP"
  }

  nat_gatway_tags = {
    Name = "NAT-Gateway"
  }
}


Then run:

terraform init
terraform plan
terraform apply

⚙️ Input Variables

vpc_cidr

Type: string

Description: CIDR block for the VPC

Default: none

Required: Yes

project_name

Type: string

Description: Project name prefix

Default: none

Required: Yes

environment

Type: string

Description: Environment name (e.g., dev, prod)

Default: none

Required: Yes

public_subnet_cidrs

Type: list(string)

Description: List of CIDRs for public subnets

Default: none

Required: Yes

private_subnet_cidrs

Type: list(string)

Description: List of CIDRs for private subnets

Default: none

Required: Yes

database_subnet_cidrs

Type: list(string)

Description: List of CIDRs for database subnets

Default: none

Required: Yes

vpc_tags

Type: map(any)

Description: Additional tags for VPC

Default: {}

Required: No

igw_tags

Type: map(any)

Description: Additional tags for Internet Gateway

Default: {}

Required: No

public_subnet_tags

Type: map(any)

Description: Tags for public subnets

Default: {}

Required: No

private_subnet_tags

Type: map(any)

Description: Tags for private subnets

Default: {}

Required: No

database_subnet_tags

Type: map(any)

Description: Tags for database subnets

Default: {}

Required: No

public_route_table_tags

Type: map(any)

Description: Tags for public route table

Default: {}

Required: No

private_route_table_tags

Type: map(any)

Description: Tags for private route table

Default: {}

Required: No

database_route_table_tags

Type: map(any)

Description: Tags for database route table

Default: {}

Required: No

eip_tags

Type: map(any)

Description: Tags for Elastic IP

Default: {}

Required: No

nat_gatway_tags

Type: map(any)

Description: Tags for NAT Gateway

Default: {}

Required: No

📤 Outputs

vpc_id

Description: The ID of the created VPC.

🌐 Resource Summary

VPC: Creates a main VPC with DNS hostnames enabled.

Internet Gateway: Provides external internet access.

Subnets: Creates public, private, and database subnets across multiple availability zones.

Elastic IP: Allocates a static IP for NAT Gateway.

NAT Gateway: Routes outbound traffic from private and database subnets.

Route Tables: Creates separate route tables for public, private, and database subnets.

Routes: Adds default routes (0.0.0.0/0) through IGW or NAT.

Associations: Associates subnets to their respective route tables.

🧩 Example Resource Names

If:

project_name = "roboshop"
environment  = "dev"


Then resources will be named like:

roboshop-dev-public-ap-south-1a
roboshop-dev-private-ap-south-1b
roboshop-dev-database-ap-south-1a
roboshop-dev-nat-gateway
roboshop-dev-public

🧠 Notes

Public subnets automatically map public IPs.

NAT Gateway is placed in the first public subnet.

The module spreads subnets across two Availability Zones for high availability.

Common tags are automatically applied to all resources.

Recommended to use remote backend (S3 + DynamoDB) for production.

🛡️ Best Practices

Use CIDR ranges large enough for scaling.

Keep NAT Gateway in one public subnet to save cost.

Always use terraform plan before applying changes.

Use Terraform workspaces for environment separation (dev, stage, prod).

👨‍💻 Maintainer

Author: Sri Yuva Teja Manikanta
Description: Developed for reusable, production-grade VPC provisioning in Terraform.