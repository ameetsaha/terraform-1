##One should not use variable for region
##Because the tfstate file gets updated with the region you pass while running "terraform apply" command.
##Think you created an EC2 instance with us-east-1 for first occurence and us-west-2 for the second occurence.
##When you try destroy us-east-1 instance, tf will have no idea because tfstate file will get updated with us-west-2 region.check "

# variable "region" {
#     type = string
#     default = "us-west-2"
# }



#Below variables are working and we try the same with object variable now.

variable "ec2_volume_config" {
  type = object({
    ec2_instance_type = string
    ec2_volume_size = number
    ec2_volume_type = string
  })
  description = "The size and type of the  root block volume for EC2 instance"
  
  default = {
    ec2_instance_type = "t2.micro"
    ec2_volume_size = 20
    ec2_volume_type = "gp3"
  } 

  validation {
    condition = contains(["t2.micro", "t3.micro"], var.ec2_volume_config.ec2_instance_type)
    error_message = "“Only t2.micro and t3.micro instances are supported."
  }
}

variable "additional_tags" {
  type = map(string)
  default = {}
  
}