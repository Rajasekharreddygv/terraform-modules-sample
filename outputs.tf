
############## NETWORK ############


output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

output "subnets_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

output "network" {
  value       = module.vpc
  description = "The created network"
}



############## SERVICE ACCOUNT ############

output "email" {
  description = "The service account email."
  value       = module.service_accounts.email
}

output "iam_email" {
  description = "The service account IAM-format email."
  value       = module.service_accounts.iam_email
}
