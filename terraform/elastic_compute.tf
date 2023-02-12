# security group allows ssh and web server connections. the Cidr block value implies any ip address can possibly make a ssh connection which is not a best practice.
resource "aws_security_group" "docker_sec" {
    name = "docker_sec_group"
    vpc_id = aws_vpc.docker-vpc.id
    description = "Allow HTTP and SSH traffic via Terraform"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# creates ec2 instance; value definition such as ubuntu ami, keypair are supplied from the variable files. 
resource aws_instance "docker_ec2" {
    ami = lookup(var.docker_var, "ami")
    instance_type = lookup(var.docker_var, "ttype")
    key_name = lookup(var.access_key, "docker_access")
    security_groups = [aws_security_group.docker_sec.id]
    subnet_id = aws_subnet.docker-subnet.id

    tags = {
    Name = "docker_project"
    Os = "ubuntu"
  }
}
