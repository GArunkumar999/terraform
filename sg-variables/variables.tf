# # variable "sg_id" {

# #     default = [aws_security_group.new-sg.id]

# # }

# Ah, I see! The error is because **variables cannot reference resources directly** in their `default` values. This is a limitation in Terraform—resource attributes like `aws_security_group.new-sg.id` cannot be referenced directly in the `default` block of a variable. Variables can only have static values (such as strings, numbers, or lists), not dynamic ones that depend on other resources.

# ### **Correct Approach**

# Instead of trying to reference the `aws_security_group` resource in the `default` value of the `sg_id` variable, you should **directly reference the security group ID in the resource definition** (such as the `aws_instance` resource). 

# ### Here's how you can handle this:

# 1. **Remove the reference to the `aws_security_group` resource from the variable.**
# 2. **Use the security group ID dynamically** in your EC2 instance resource directly from the `aws_security_group` resource.

# ### Example Configuration:

# #### 1. **Define the Security Group**:
# ```hcl
# # Create the security group
# resource "aws_security_group" "new_sg" {
#   name        = "new-sg"
#   description = "Allow SSH access"
#   tags = {
#     Name = "new-sg"
#   }

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"  # Allow all outbound traffic
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
# ```

# #### 2. **Reference the Security Group ID in EC2 Instance Resource**:
# Instead of using a variable to reference the security group ID, you can directly reference the security group ID within the `aws_instance` resource.

# ```hcl
# # Declare the EC2 instance using the security group created
# resource "aws_instance" "newinstance" {
#   ami           = "ami-0ac4dfaf1c5c0cce9"  # Replace with a valid AMI ID
#   instance_type = "t2.micro"
#   key_name      = "arun"

#   # Directly reference the security group ID
#   vpc_security_group_ids = [aws_security_group.new_sg.id]

#   tags = {
#     Name = "TERRAFORM"
#   }
# }
# ```

# #### 3. **Use `output` to Display the Security Group ID**:
# If you'd like to see or use the security group ID elsewhere, you can define an `output` block.

# ```hcl
# # Output the security group ID for reference
# output "sg_id" {
#   value = aws_security_group.new_sg.id
# }
# ```

# ### **What Changed**:
# - You **no longer need** a variable to store the security group ID. You are now referencing the security group directly with `aws_security_group.new_sg.id` in the `vpc_security_group_ids` attribute.
# - The `output` block allows you to display or use the `new_sg.id` later, but **you don't need to pass it through a variable anymore**.

# ### **Summary of Key Concepts**:
# - **Variables**: They can’t be used to reference resources like `aws_security_group.new_sg.id` because variables only accept static values.
# - **Resource Reference**: You can directly reference a resource's attribute (like `aws_security_group.new_sg.id`) in another resource, such as `aws_instance`.

# This approach should solve the issue, and you won't see the "Variables not allowed" error anymore. Let me know if you need more help!