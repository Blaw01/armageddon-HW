# Output Information using your naming convention
output "hq_vpc_public_ip" {
  value = google_compute_instance.hq_instance.network_interface[0].access_config[0].nat_ip # Assuming public IP is desired
}

output "hq_vpc_name" {
  value = google_compute_network.hq_vpc.name
}

output "hq_subnet_name" {
  value = google_compute_subnetwork.hq_subnet.name
}

output "hq_instance_internal_ip" {
  value = google_compute_instance.hq_instance.network_interface.0.network_ip
}

output "clickable_web_link" {
  value = format("http://%s", google_compute_instance.hq_instance.network_interface.0.access_config.0.nat_ip)
}