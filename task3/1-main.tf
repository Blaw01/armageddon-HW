
# Instance in Europe HQ subnet
resource "google_compute_instance" "hq_instance" {
  name         = "europe-instance"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 50
    }
    auto_delete = true
  }

  network_interface {
    network    = google_compute_network.hq_vpc.name
    subnetwork = google_compute_subnetwork.hq_subnet.name

    access_config {
      // Ephemeral public IP
    }

  }
  tags = ["http-server"]

  metadata_startup_script = file("${path.module}/startup.sh")
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


# Firewall Rule to Allow SSH Traffic in Americas
resource "google_compute_firewall" "allow_ssh" {
  #project = var.project_id
  name    = "allow-ssh"
  network = google_compute_network.america_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_tags   = ["ssh"]
  source_ranges = ["0.0.0.0/0"] # Allow SSH access from any IP address
}

# Firewall Rule to Allow Port 80 Traffic in Americas
resource "google_compute_firewall" "allow_port_80_americas" {
  #project = var.project_id
  name    = "allow-port-80-americas"
  network = google_compute_network.america_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}
