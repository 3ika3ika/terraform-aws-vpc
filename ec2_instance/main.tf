locals {
  ami_map = {
    "us-east-1" = "ami-0453ec754f44f9a4a"
    "us-west-1" = "ami-038bba9a164eb3dc1"
    "us-west-2" = "ami-055e3d4f0bbeb5878"
  }
}



resource "aws_security_group" "ec2_sg" {
  name        = var.name
  vpc_id      = var.vpc_id # Input variable for VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sec-grp"
  }
}

resource "aws_instance" "ec2_instance" {
  count = length(var.subnet_ids) # Dynamically create instances based on the number of subnets provided

  ami           = local.ami_map[var.region]
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index] # Use the current subnet from the list
  key_name = var.key_name
  

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "${var.name}-instance-${count.index}"
  }
}
