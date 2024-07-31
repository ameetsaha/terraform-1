resource "aws_instance" "as94054_001_webservice" {
  #ami                         = "ami-04a81a99f5ec58529" #Ubuntu for us-east-1
  #ami                         = "ami-0aff18ec83b712f05"  #Ubuntu for us-west-2
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  #instance_type               = "t3.micro"
  instance_type               = var.ec2_volume_config.ec2_instance_type
  subnet_id                   = aws_subnet.as94054_001_pubsub.id
  vpc_security_group_ids      = [aws_security_group.as94054_001_allow_80.id]
 
  root_block_device {
    delete_on_termination = true   # Delete volume when terminating this EC2 Instance
    volume_size           = var.ec2_volume_config.ec2_volume_size
    volume_type           = var.ec2_volume_config.ec2_volume_type
  }

  user_data = file("userdata.tpl")
  #key_name = "as94054_tf"   # Integrating this existing keypair which is alerady created/available in my AWS Account.
  key_name = "as94054_tf2"   # Integrating this existing keypair which is alerady created/available in my AWS Account.
  tags = merge(local.common_tags, {
    Name = "EC2 Instance for project as94054_001"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "as94054_001_allow_80" {
  description = "This SG is created to access NGINX Service externally by Public IP addeess"
  vpc_id      = aws_vpc.as94054_001.id
  name = "SG for project as94054_001"

  egress {                                                         # All outbound connections are allowed.
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = "This Security Group is created to allow open port 80 for project as94054_001"
  })
}