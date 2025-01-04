output "security_group_id" {
  value = aws_security_group.ec2_sg.id
}

output "instance_ids" {
  description = "IDs of all created instances"
  value       = [for i in range(length(aws_instance.ec2_instance)) : aws_instance.ec2_instance[i].id]
}

output "instance_public_ips" {
  description = "Public IPs of all created instances"
  value       = [for i in range(length(aws_instance.ec2_instance)) : aws_instance.ec2_instance[i].public_ip]
}

output "instance_private_ips" {
  description = "Private IPs of all created instances"
  value       = [for i in range(length(aws_instance.ec2_instance)) : aws_instance.ec2_instance[i].private_ip]
}
