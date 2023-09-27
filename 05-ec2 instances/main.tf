terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

variable "aws_key_pair" {
  default = "~/aws/aws_keys/default-ec2.pem"
}

// Default VPC
resource "aws_default_vpc" "default" {
  tags = { Name : "Default VPC" }
}

// HTTP SERVER -> SG
//SECURITY GROUP(SG) 80 TCP, 22 TCP, CIDR ["0.0.0.0/0"]

resource "aws_security_group" "http_server_sg" {
  name = "http_server_sg"
  // vpc_id = "vpc-06358980fc63c14e3"
  vpc_id = aws_default_vpc.default.id
  ingress = [{
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = true
    },
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
  }]

  egress = [{
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = true
  }]

  tags = {
    name = "http_server_sg"
  }
}

resource "aws_instance" "http_server" {
  ami                    = "ami-03a6eaae9938c858c"
  key_name               = "default ec2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = "subnet-0e1c23f099f55178c"

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                         // install httpd
      "sudo service httpd start",                                                                          // start httpd
      "echo welcome hillary - virtual server is at ${self.public_dns} | sudo tee /var/www/html/index.html" // Copy a file
    ]
  }
}
