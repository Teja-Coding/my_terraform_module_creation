resource "aws_instance" "this" {
  ami           = var.ami_id     #mandatory
  instance_type = var.instance_type    #mandatory
  vpc_security_group_ids = var.sg_ids  #mandatory  
  tags = var.tags #optional
}


# resource "aws_security_group" "my_sg" {
#   name   = "my_sg"
  
#     egress {
#     from_port       = var.egress_from_port
#     to_port         = var.egress_to_prot  
#     protocol        = var.protocol
#     cidr_blocks = var.cidr_blocks
#   }

#     ingress {
#     from_port       = var.ingress_from_port
#     to_port         = var.ingress_to_port
#     protocol        = var.protocol
#     cidr_blocks = var.cidr_blocks

#   }

#   tags = var.ec2_sg_tags

# }