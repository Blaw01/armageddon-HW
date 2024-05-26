# VPC and Subnetwork for Europe Headquarters
resource "google_compute_network" "hq_vpc" {
  name                    = "law-eu-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}

resource "google_compute_subnetwork" "hq_subnet" {
  name          = var.subnet_hq
  network       = google_compute_network.hq_vpc.self_link
  ip_cidr_range = var.hq_cidr_range
  region        = var.hq_region
}

# VPC and Subnetwork for Americas Headquarters
resource "google_compute_network" "america_vpc" {
  name                    = "america-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}

# First subnet for the Americas Network
resource "google_compute_subnetwork" "america_subnet" {
  name          = var.subnet_1
  ip_cidr_range = var.ip_cidr_range2
  region        = var.region1
  network       = google_compute_network.america_vpc.self_link
}

# Second subnet for the Americas Network
resource "google_compute_subnetwork" "america_subnet2" {
  name          = var.subnet_2
  ip_cidr_range = var.ip_cidr_range3
  region        = var.region2
  network       = google_compute_network.america_vpc.self_link
}

# VPC and Subnetwork for Asia Region
resource "google_compute_subnetwork" "asia_subnet" {
  name                     = var.subnet_asia
  network                  = google_compute_network.hq_vpc.self_link
  ip_cidr_range            = var.asia_cidr_range
  private_ip_google_access = true
  region                   = var.region_2
}


############################ Peering ##########################################


# Global Address for HQ to Remote VPC Peering
resource "google_compute_global_address" "hq_to_remote_vpc_global_address" {
  name          = var.hq-to-remote-address
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.hq_vpc.id
}

# Network Peering: Remote to HQ
resource "google_compute_network_peering" "remote_to_hq_peer" {
  name         = var.remote_to_hq_peer
  network      = google_compute_network.america_vpc.self_link
  peer_network = google_compute_network.hq_vpc.self_link
}

# Auto-created Network for Europe Peering
resource "google_compute_network" "eu_peer1_vpcn_network" {
  name                    = "europe-peering-net"
  auto_create_subnetworks = "true"
}


# Global Address for Remote to HQ VPC Peering
resource "google_compute_global_address" "remote_to_hq_vpc_global_address" {
  name          = var.remote-to-hq-address-1
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.america_vpc.id
}


# Network Peering: HQ to Remote
resource "google_compute_network_peering" "hq_to_remote_peer" {
  name         = var.hq_to_remote_peer
  network      = google_compute_network.hq_vpc.self_link
  peer_network = google_compute_network.america_vpc.self_link
}

# Auto-created Network for Americas Peering
resource "google_compute_network" "americas_peer1_vpc_network" {
  name                    = "americas-peering-net"
  auto_create_subnetworks = "true"
}