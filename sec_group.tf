resource "aws_security_group" "docker" {
  name = "docker"
  description = "docker_sec_group"
  vpc_id = data.aws_vpc.vpc_2.id

  ingress {
    description = "ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "5000/5001"
    from_port = 5000
    to_port = 5001
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "10.0.0/16"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "8086"
    from_port = 8086
    to_port = 8086
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "traffic"
  }
}
