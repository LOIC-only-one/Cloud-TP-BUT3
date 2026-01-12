# ==================== VPC OUTPUTS ====================

output "vpc_id" {
  description = "ID du VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID du subnet public"
  value       = aws_subnet.public.id
}

# ==================== INSTANCE OUTPUTS ====================

output "instance_ids" {
  description = "IDs des instances EC2"
  value       = aws_instance.web[*].id
}

output "instance_ips_public" {
  description = "IPs publiques (SSH/HTTP)"
  value       = aws_instance.web[*].public_ip
}

output "instance_ips_private" {
  description = "IPs privées"
  value       = aws_instance.web[*].private_ip
}

# ==================== ANSIBLE OUTPUTS ====================

output "instance_ips" {
  description = "IPs publiques formatées pour Ansible"
  value = {
    for i, instance in aws_instance.web :
    instance.tags["Name"] => instance.public_ip
  }
}

# Inventaire Ansible ready-to-use
output "ansible_inventory" {
  description = "Inventaire Ansible (copy-paste)"
  value = "[webservers]\n${join("\n", [
    for i, instance in aws_instance.web :
    "${instance.tags["Name"]} ansible_host=${instance.public_ip} ansible_user=ubuntu"
  ])}\n\n[webservers:vars]\nansible_ssh_private_key_file=~/.ssh/id_rsa"
}

# ==================== SUMMARY ====================

output "deployment_summary" {
  description = "Résumé du déploiement"
  value = {
    vpc_cidr       = aws_vpc.main.cidr_block
    subnet_cidr    = aws_subnet.public.cidr_block
    instances_count = var.instance_count
    instance_type  = var.instance_type
  }
}