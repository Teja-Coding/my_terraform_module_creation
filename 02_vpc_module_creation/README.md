🧾 README.md
# 🚀 Terraform AWS VPC Module

This Terraform module provisions a **complete VPC setup** on AWS, including:
- VPC with DNS hostnames enabled
- Public, private, and database subnets (multi-AZ)
- Internet Gateway
- NAT Gateway with Elastic IP
- Route tables and associations for each subnet type

Designed for **multi-environment** setups (e.g. `dev`, `staging`, `prod`) and **tag consistency** across resources.

---

## 🏗️ Features

- ✅ Creates VPC with configurable CIDR block  
- ✅ Supports multiple availability zones  
- ✅ Configurable public, private, and database subnets  
- ✅ Public subnets connected to Internet Gateway  
- ✅ Private and database subnets route traffic via NAT Gateway  
- ✅ Automatically tags all resources using `project_name`, `environment`, and `Terraform=true`

---

## 📦 Module Structure



.
├── main.tf # Core resources: VPC, subnets, routes, NAT, IGW
├── variables.tf # Input variables
├── outputs.tf # Exported values
├── locals.tf # Common naming and tagging logic
└── README.md # Documentation (this file)


---

## 🧩 Usage Example

```hcl
module "vpc" {
  source = "../path_to_module"

  project_name = "roboshop"
  environment  = "dev"
  vpc_cidr     = "10.0.0.0/16"

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  database_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]

  # Optional tagging
  vpc_tags = {
    Owner = "Sri Yuva Teja"
  }

  igw_tags = {
    Purpose = "Internet Access"
  }

  public_subnet_tags = {
    Tier = "Public"
  }

  private_subnet_tags = {
    Tier = "Private"
  }

  database_subnet_tags = {
    Tier = "Database"
  }

  public_route_table_tags = {
    RouteType = "Public"
  }

  private_route_table_tags = {
    RouteType = "Private"
  }

  database_route_table_tags = {
    RouteType = "Database"
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
Name	Type	Description	Default	Required
vpc_cidr	string	CIDR block for the VPC	n/a	✅ Yes
project_name	string	Name of the project	n/a	✅ Yes
environment	string	Environment name (e.g., dev, prod)	n/a	✅ Yes
public_subnet_cidrs	list(string)	List of CIDRs for public subnets	n/a	✅ Yes
private_subnet_cidrs	list(string)	List of CIDRs for private subnets	n/a	✅ Yes
database_subnet_cidrs	list(string)	List of CIDRs for database subnets	n/a	✅ Yes
vpc_tags	map(any)	Additional tags for VPC	{}	❌ No
igw_tags	map(any)	Additional tags for Internet Gateway	{}	❌ No
public_subnet_tags	map(any)	Tags for public subnets	{}	❌ No
private_subnet_tags	map(any)	Tags for private subnets	{}	❌ No
database_subnet_tags	map(any)	Tags for database subnets	{}	❌ No
public_route_table_tags	map(any)	Tags for public route table	{}	❌ No
private_route_table_tags	map(any)	Tags for private route table	{}	❌ No
database_route_table_tags	map(any)	Tags for database route table	{}	❌ No
eip_tags	map(any)	Tags for Elastic IP	{}	❌ No
nat_gatway_tags	map(any)	Tags for NAT Gateway	{}	❌ No
📤 Outputs
Name	Description
vpc_id	The ID of the created VPC
🌐 Resource Summary
Resource	Count / Purpose
aws_vpc	1 – main VPC
aws_internet_gateway	1 – for public subnets
aws_subnet	multiple – public, private, and database
aws_eip	1 – for NAT gateway
aws_nat_gateway	1 – routes private/database subnet traffic
aws_route_table	3 – public, private, database
aws_route	3 – default routes for each route table
aws_route_table_association	N – associates subnets with their route tables
🧠 Notes

Public subnets automatically map public IPs.

NAT Gateway is deployed in the first public subnet.

All subnets are spread across two availability zones for high availability.

The locals block automatically generates:

common_name_suffix as <project_name>-<environment>

Common tags for consistency.

🧩 Example Generated Names

If:

project_name = "roboshop"
environment  = "dev"


Then resources will be named like:

roboshop-dev-public-ap-south-1a
roboshop-dev-private-ap-south-1b
roboshop-dev-database-ap-south-1a
roboshop-dev-nat-gateway
roboshop-dev-public

🛡️ Best Practices

Use CIDRs with enough space for future scaling.

Deploy the NAT Gateway only in the first public subnet for cost efficiency.

Use terraform destroy carefully; this module creates real networking resources.

Manage backend state (S3 + DynamoDB) for team usage.

👨‍💻 Maintainer

Author: Sri Yuva Teja Manikanta