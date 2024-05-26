# VPC and Subnetwork for Asia Region
resource "google_compute_instance" "asia_instance" {
  name         = "asia-instance"
  machine_type = "e2-medium"         # Adjust machine type as needed
  zone         = "asia-southeast1-b" # Adjust zone as needed

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2022" # Windows Server 2019 image
      size  = 50
    }
    auto_delete = true
  }

  network_interface {
    network    = google_compute_network.hq_vpc.self_link         # Reference the asia VPC
    subnetwork = google_compute_subnetwork.asia_subnet.self_link # Reference the asia subnet

    access_config {
      // Ephemeral public IP
    }
  }
  tags = ["http-server", "rdp-enabled"]
}



resource "google_compute_firewall" "europe_rdp" {
  name        = "europe-rdp"
  network     = google_compute_network.hq_vpc.self_link
  description = "Allow RDP traffic from any source"
  #direction   = "INGRESS"
  #priority    = 1000

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"] # add asia's ip range

  target_tags = ["rdp-enabled"]
}

