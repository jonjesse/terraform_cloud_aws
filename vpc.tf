#Get the ID of your VPC and save it in .tfvars file
#include -var-file="file" in terraform command line
#if not supplied you will be asked for it

variable "vpc_id" {}

data "aws_vpc" "vpc_2" {
   id = var.vpc_id
}

output "aws_vpc" {
  value = data.aws_vpc.vpc_2.id
}
