# Compute Instance 1 in Americas VPC
resource "google_compute_instance" "america_instance_1" {
  name         = "america-instance-1"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
    auto_delete = true
  }

  network_interface {
    network    = google_compute_network.america_vpc.self_link
    subnetwork = google_compute_subnetwork.america_subnet.self_link

    access_config {
      // Ephemeral public IP
    }

  }

  tags = ["http-server"]
}

# Compute Instance 2 in Americas VPC
resource "google_compute_instance" "america_instance_2" {
  name         = "america-instance-2"
  machine_type = "e2-micro"
  zone         = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
    auto_delete = true
  }

  network_interface {
    network    = google_compute_network.america_vpc.self_link
    subnetwork = google_compute_subnetwork.america_subnet2.self_link

    access_config {
      // Ephemeral public IP
    }

  }

  tags = ["http-server"]
}