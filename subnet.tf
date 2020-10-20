#Create new docker subnet
resource "aws_subnet" "docker" {
   vpc_id = data.aws_vpc.vpc_2.id 
   cidr_block = "10.0.3.0/24"
   map_public_ip_on_launch = "true"
   tags = { Name = "Docker" }
}

output "subnet_id" {
  value = aws_subnet.docker.id
}
