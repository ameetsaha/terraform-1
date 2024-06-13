terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "t1"

  instance_type          = "t3.micro"
  key_name               = "vaishu"
  monitoring             = true
  vpc_security_group_ids = ["sg-03946aa60e5ded4b0"]
  subnet_id              = "subnet-0bf75427a7b9569dd"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
