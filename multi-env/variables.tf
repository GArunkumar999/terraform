variable "names" {
  default = ["mysql", "backend", "frontend"]

}

variable "environment" {

}

variable "project" {
  default = "expense"
}

variable "common_tags" {
  type = map(any)
  default = {
    Project = "expense"
  }
}