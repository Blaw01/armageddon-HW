
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
