variable "cidr_range" {
  default = "10.0.0.0/16"
}

variable "vpc_tag"{
  default = {
    region = "us-east-1"
    purpose = "expense-project"
  }
  
}

variable "cidr_list_public"{
    type = list
    default = ["10.0.0.0/24","10.0.1.0/24"]
  
}

variable "cidr_list_private" {
    type = list
    default = ["10.0.2.0/24","10.0.3.0/24"]
  
}
variable "cidr_list_database" {
    type = list
    default = ["10.0.4.0/24","10.0.5.0/24"]
  
}
variable "project" {
  default = "expense"
  
}
variable "environment" {
  default = "prod"
  
}
variable "app" {
  default = "mysql"
  
}