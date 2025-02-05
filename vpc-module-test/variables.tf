variable "cidr" {
  default = "10.0.0.0/24"
}

variable "tags" {
   default = {
   project = "expense"
   environment = "prod"
    }
  
}

variable "usecase" {
  default = {
  purpose = "web-server"
    }
}
