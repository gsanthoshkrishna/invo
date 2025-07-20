terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"          # Choose your AWS region
  profile = "default"            # Or your AWS CLI profile name
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform_ec2_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your IP or 0.0.0.0/0 for open access (not recommended)
  }
}

resource "aws_instance" "aks-test" {
  ami           = "ami-04f167a56786e4b09"
  instance_type = "t3.large"                # Free tier eligible instance type
  key_name      = aws_key_pair.ssh_key.key_name
  tags = {
    Name = "aks-test-instance"
  }
}
