#Gets latest version of Ubuntu 18, deployes it, installs docker and starts swarm
#Update your private ssh key 

data "aws_ami" "ubuntu" {
  most_recent      = true
  #owners           = ["self"]
  owners = ["099720109477"]
  name_regex = "ubuntu*"

  filter {
    name = "name"
    values = ["*ubuntu-bionic-18*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
 
}

output "ubuntu_image" {
  value = data.aws_ami.ubuntu.id
}

resource "aws_instance" "docker1" {
   ami = data.aws_ami.ubuntu.id
   instance_type = "t2.medium"
   key_name = "aws5"
   vpc_security_group_ids = [aws_security_group.docker.id]
   subnet_id = aws_subnet.docker.id
   tags = { 
	Name = "docker1" 
   }

  provisioner "file" {
  source = "/home/master.sh"
  destination = "/home/ubuntu/master.sh"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = var.priv_key
    host = aws_instance.docker1.public_ip
    }
  }

  provisioner "file" {
  source = "/home/monitor.sh"
  destination = "/home/ubuntu/monitor.sh"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file ("aws5")
    host = aws_instance.docker1.public_ip
    }
  }

   provisioner "remote-exec" {
    inline = [
     "sleep 250",
     "echo public IP is: ${aws_instance.docker1.public_ip}",
     "sudo killall apt apt-get",
     "sudo apt-get update",
     "sudo apt-get install -y nginx vim",
     "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common",
     "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add",
     "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
     "sudo apt-get update",
     "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
     "sudo docker run hello-world",
     "sleep 10",
     "echo ${aws_instance.docker1.private_ip} > /home/ubuntu/private_ip",
     "sudo cp /home/ubuntu/private_ip /var/www/html/private_ip",
     "chmod 755 /home/ubuntu/master.sh",
     "chmod 755 /home/ubuntu/monitor.sh",
     "/home/ubuntu/master.sh",
     "/usr/bin/nohup /home/ubuntu/monitor.sh &",
     "sleep 3"
     ]
 
    connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file ("aws5")
     host = aws_instance.docker1.public_ip
    }
   }
}

output "docker1" {
  value = aws_instance.docker1.private_ip
}

output "app_state_docker1" {
  value = aws_instance.docker1.instance_state
}
