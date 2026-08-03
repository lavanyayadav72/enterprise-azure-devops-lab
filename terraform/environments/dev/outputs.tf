output "web_vm_private_ip" {
  description = "Web VM private IP"
  value       = module.web_nic.private_ip_address
}


output "web_vm_name" {
  description = "Web VM name"
  value       = module.web_vm.name
}

output "web_vm_02_name" {
  value = module.web_vm_02.name
}

output "web_vm_02_private_ip" {
  value = module.web_vm_02.private_ip
}

output "app_vm_name" {
  value = module.app_vm_01.name
}

output "app_vm_private_ip" {
  value = module.app_vm_01.private_ip
}

output "application_gateway_public_ip" {
  description = "Application Gateway Public IP"
  value       = module.app_gateway_public_ip.ip_address
}

output "application_gateway_subnet_id" {
  value = module.appgateway_subnet.id
}