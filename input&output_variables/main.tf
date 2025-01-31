# Variables Demo

# Configure the AWS provider using the input variables
provider "aws" {
  region = "us-east-1"
}

# Define an input variable for the EC2 instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# Define an input variable for the EC2 instance AMI ID
variable "ami_id" {
  description = "EC2 AMI ID"
  type        = string
  default     = "ami-0c614dee691cbbf37"
}


# Create an EC2 instance using the input variables
resource "aws_instance" "example_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
}

# Define an output variable to expose the public IP address of the EC2 instance
output "full_output"{
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.example_instance #full output
}

output "availability_zone"{
  description = "print availability zone"
  value       = aws_instance.example_instance.availability_zone #only availability zone
}
