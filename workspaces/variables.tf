variable "instances" {
    type = list(string)
    default = ["mysql","backend","frontend"]
  
}

# variable "environment" {
  
# }

variable "project" {

    default = "expense"
  
}

variable "domain_name" {
    default = "devopslearning.fun"
  
}

variable "instance_type" {
  default = "t2.micro"
}
