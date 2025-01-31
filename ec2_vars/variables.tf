variable "ami_id" {
  default = "ami-0ac4dfaf1c5c0cce9"

}

variable "instance_type" {
  type = string
  default = "t2.micro"

}

variable "key_name" {
  default = "arun"
}

variable "tag_name"{
    default = ["mysql","backend","frontend"]
}