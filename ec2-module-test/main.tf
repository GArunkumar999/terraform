
#if you have your module in remote repo like github

module "ec2_instance" {
  source = "github.com/GArunkumar999/terraform//ec2-module?ref=main"
  #(wrong)https://github.com/GArunkumar999/terraform/tree/main/ec2-module
  instance_type = "t3.small"
  sg_id         = "sg-080764e4379a0f518"
  project_name  = "expense"
  usecase       = { purpose = "ec2" }

}

#if you have your module in local repo

# module "ec2_instance" {
#   source  = "../ec2-module"
#   instance_type  = "t3.small"
#   sg_id = "sg-080764e4379a0f518"
#   project_name = "expense"
#   usecase = {purpose = "ec2" }

# }
