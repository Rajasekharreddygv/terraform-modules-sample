
############## NETWORK ############

variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  default     = "q-gcp-7959-genesysstaff-22-06"
}

variable "network_name" {
  description = "The name of the network being created"
  default     = "example-vpc"
}

variable "routing_mode" {
  description = "The network routing mode (default 'GLOBAL')"
  default     = "GLOBAL"
}

variable "subnet_01_name" {
  description = "The subnets being created"
  default     = "subnet-01"
}

variable "subnet_01_ip" {
  description = "The subnets ip being created"
  default     = "10.10.10.0/24"
}

variable "subnet_01_region" {
  description = "The subnets region being created"
  default     = "us-central1"
}



variable "routes_01_name" {
  description = "The routes being created"
  default     = "egress-internet-subnet-01"
}

variable "routes_01_destination_range" {
  description = "The routes destination range being created"
  default     = "0.0.0.0/0"
}


############## SERVICE ACCOUNT ############

variable "sa_name" {
  description = "The name of the service account being created"
  type        = list(any)
  default     = ["test-sa"]
}
