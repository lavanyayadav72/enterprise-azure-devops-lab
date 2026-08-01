output "web_vm_private_ip" {
  description = "Web VM private IP"
  value       = module.web_nic.private_ip_address
}


output "web_vm_name" {
  description = "Web VM name"
  value       = module.web_vm.name
}

