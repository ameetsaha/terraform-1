terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "t1"

  instance_type          = "t3.micro"
  key_name               = "as94054_tf"
  monitoring             = true
  vpc_security_group_ids = ["sg-0915d09e8290de738"]
  subnet_id              = "subnet-06d807c040db6403d"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
