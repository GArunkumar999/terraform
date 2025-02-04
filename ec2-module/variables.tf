variable "instance_type" {
  type = string 
  #default = "t2.micro"
  validation {
        condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
        error_message = "Valid values for instance type are: t3.small t3.medium t3.micro"
    } 
}

variable "ami_id" {
    type = string
    default = "ami-0c614dee691cbbf37"
  
}

#mandatory
variable "project_name" {
  
}

#mandatory
variable "sg_id" {

    type = string
  
}

variable "common_tags" {
  default = {
    project = "expense"
    environment = "dev"
  }
}
#optional
# variable "sg_id" {

#     type = string
#     default = {}
# }

variable "usecase" {
    type = map
  # default = {}
}