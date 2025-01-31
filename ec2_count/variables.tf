variable "names" {
  type    = list(string)
  default = ["mysql", "backend", "frontend"]
}

variable "domain" {
    type = string
    default = "devopslearning.fun"
  
}
