variable "instance" {

  default = {
    mysql    = "t2.small"
    backend  = "t2.micro"
    frontend = "t3.micro"
  }

}

variable "domain" {

  default = "devopslearning.fun"

}

variable "zone_id" {
  default = "Z08422171C6OWFSY3CZBI"
}