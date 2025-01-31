output "instance_public_ips" {
  value = { for idx, inst in aws_instance.newinstance : inst.id => inst.public_ip }
}