
############## NETWORK ############

module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "5.1.0"
  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = var.routing_mode

  subnets = [
    {
      subnet_name   = var.subnet_01_name
      subnet_ip     = var.subnet_01_ip
      subnet_region = var.subnet_01_region
    }
  ]

  routes = [
    {
      name              = var.routes_01_name
      destination_range = var.routes_01_destination_range
      next_hop_internet = "true"
    }
  ]
}

############## FIREWALLS ############

module "network_firewall-rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version      = "5.1.0"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  rules = [{
    name                    = "allow-ssh-ingress"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}

############## SERVICE ACCOUNT ############

module "service_accounts" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "4.1.1"
  project_id = var.project_id
  names      = var.sa_name
  project_roles = [
    "${var.project_id}=>roles/editor",
  ]
}

############## VM ############

resource "google_compute_instance" "default" {
  name         = "example-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "Ubuntu 18.04 LTS"
    }
  }

  network_interface {
    network    = module.vpc.network_name
    subnetwork = module.vpc.subnets_names[0]

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    email  = module.service_accounts.email
    scopes = ["cloud-platform"]
  }
}
