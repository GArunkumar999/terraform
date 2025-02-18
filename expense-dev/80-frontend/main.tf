
# AWS Instance
resource "aws_instance" "frontend" {
  ami           = "ami-09c813fb71547fc4f"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.frontend_sg_id.value]
   subnet_id     = local.pub_id[0]
   associate_public_ip_address = true

 
  tags = {
    Name = "${var.project}-${var.environment}-frontend"
  }
}

resource "null_resource" "frontend" {
  # Changes to any instance of the backend requires re-provisioning
  triggers = {
    Instance_id = aws_instance.frontend.id
  }

  # Bootstrap script can run on any instance of the backend
  # So we just choose the first in this case
  connection {
    host = aws_instance.frontend.public_ip
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
  }

    provisioner "file" {
    source      = "frontend.sh"
    destination = "/tmp/frontend.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the backend
    inline = [
       "chmod +x /tmp/frontend.sh",
      "sudo sh /tmp/frontend.sh ${var.environment}",
    ]
  }
}

resource "aws_ec2_instance_state" "frontend_stop" {
  instance_id = aws_instance.frontend.id
  state       = "stopped"
  depends_on = [null_resource.frontend]
}

resource "aws_ami_from_instance" "frontend_ami" {
  name               = "nginx"
  source_instance_id = aws_instance.frontend.id
  depends_on = [aws_ec2_instance_state.frontend_stop]
  provisioner "local-exec" {
    command =  "aws ec2 terminate-instances --instance-ids ${aws_instance.frontend.id}"
  }
}



