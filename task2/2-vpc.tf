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

resource "google_compute_firewall" "hq_firewall" {
  name    = "hq-firewall"
  network = google_compute_network.hq_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

