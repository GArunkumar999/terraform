output "pvt_ip1" {
  value = aws_instance.server1.private_ip
  sensitive = true #hide output
}

output "pvt_ip2" {
  value = aws_instance.server2.private_ip
  sensitive = false #show output
}

output "pvt_ip3" {
  value = aws_instance.server3.private_ip
  sensitive = true
  
}

output "instance_details" {
  value = {
    description = "server1 details"
    id          = aws_instance.server1.id
    public_ip   = aws_instance.server1.public_ip
    private_ip  = aws_instance.server1.private_ip
    instance_type = aws_instance.server1.instance_type
  }
}