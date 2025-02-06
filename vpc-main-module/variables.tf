variable "cidr_block" {
  
}

variable "common_tags" {
    default = {
        project_name = "expense"
        Account_name = "BMO"
    
    }
  
}

#optional
variable "vpc_tags"{
      default = {}
}

variable "cidr_public"{

  validation {
    condition     = length(var.cidr_public) ==2
    error_message = "please provide two cidr ip ranges"
  }
}

variable "cidr_private" {

  validation {
    condition     = length(var.cidr_private) == 2
    error_message = "please provide two cidr ip ranges"
  }
}

variable "cidr_database" {

  validation {
    condition     = length(var.cidr_database) ==2
    error_message = "please provide two cidr ip ranges"
  }
}


variable "project" {
    default = "expense"
}

variable "is_vpc_peering_required" {
  default = false
  
}
