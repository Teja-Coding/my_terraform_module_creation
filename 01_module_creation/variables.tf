variable "ami_id" {
  type = string
  description = "this is the ami used for creation ec2 instance"
}

variable "instance_type" {
  type = string
  description = "instance type used for creating ec2 instance"
  validation {
    condition = contains(["t3.micro","t3.small","t3.medium"],var.instance_type)
    error_message = "pls select either t3 micro or small medium"
  }
}

variable "sg_ids" {
  type = list  
}

variable "tags" {
  type = map
  default = {}
}

