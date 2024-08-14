terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"

  tags = {
    Name = "myfirstterraform instance"
  }
}
