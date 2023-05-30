terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.13.4"
}

provider "aws" {
  region  = "eu-west-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  count = 1

  tags = {
    Name = "Server${count.index+ 1 }",
  }
}
