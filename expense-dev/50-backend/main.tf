
# AWS Instance
resource "aws_instance" "backend" {
  ami           = "ami-09c813fb71547fc4f"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
   subnet_id     = local.pvt_id[0]

 
  tags = {
    Name = "${var.project}-${var.environment}-backend"
  }
}

resource "null_resource" "backend" {
  # Changes to any instance of the backend requires re-provisioning
  triggers = {
    Instance_id = aws_instance.backend.id
  }

  # Bootstrap script can run on any instance of the backend
  # So we just choose the first in this case
  connection {
    host = aws_instance.backend.private_ip
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
  }

    provisioner "file" {
    source      = "backend.sh"
    destination = "/tmp/backend.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the backend
    inline = [
       "chmod +x /tmp/backend.sh",
      "sudo sh /tmp/backend.sh ${var.environment}",
    ]
  }
}

resource "aws_ec2_instance_state" "backend_stop" {
  instance_id = aws_instance.backend.id
  state       = "stopped"
  depends_on = [null_resource.backend]
}

resource "aws_ami_from_instance" "backend_ami" {
  name               = "nodejs"
  source_instance_id = aws_instance.backend.id
  depends_on = [aws_ec2_instance_state.backend_stop]
  provisioner "local-exec" {
    command =  "aws ec2 terminate-instances --instance-ids ${aws_instance.backend.id}"
  }
}



