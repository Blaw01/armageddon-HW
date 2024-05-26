# Gateway (VPN Gateway):
resource "google_compute_vpn_gateway" "europe_vpn_gateway" {
  name       = "europe-vpn-gateway"
  network    = google_compute_network.hq_vpc.id
  region     = var.hq_region
  depends_on = [google_compute_subnetwork.hq_subnet]
}


# Reserved Static IP Address:
resource "google_compute_address" "eu_static_ip" {
  name   = "region-1-static-ip"
  region = var.hq_region
}



# Forwarding Rule for ESP traffic:
resource "google_compute_forwarding_rule" "rule_esp_fw" {
  name        = "rule-esp-europe"
  region      = var.hq_region
  ip_protocol = "ESP"
  ip_address  = google_compute_address.eu_static_ip.address
  target      = google_compute_vpn_gateway.europe_vpn_gateway.self_link
}


# Forwarding Rule for UDP Port 500 traffic
resource "google_compute_forwarding_rule" "rule_udp_500" {
  name        = "rule-udp500-europe"
  region      = var.hq_region
  ip_protocol = "UDP"
  ip_address  = google_compute_address.eu_static_ip.address
  port_range  = "500"
  target      = google_compute_vpn_gateway.europe_vpn_gateway.self_link
}


# Forwarding Rule for UDP Port 4500 traffic
resource "google_compute_forwarding_rule" "rule_udp_4500" {
  name        = "rule-udp4500-europe"
  region      = var.hq_region
  ip_protocol = "UDP"
  ip_address  = google_compute_address.eu_static_ip.address
  port_range  = "4500"
  target      = google_compute_vpn_gateway.europe_vpn_gateway.self_link
}

# Tunnel from Europe to Asia
resource "google_compute_vpn_tunnel" "europe_to_asia_tunnel" {
  name                    = "europe-to-asia-tunnel"
  target_vpn_gateway      = google_compute_vpn_gateway.europe_vpn_gateway.self_link
  peer_ip                 = google_compute_address.asia_static_ip.address
  shared_secret           = "Lawstask" # Replace with your shared secret
  ike_version             = 2
  local_traffic_selector  = ["10.108.10.0/24"] # Replace with Europe VPC subnet
  remote_traffic_selector = ["192.168.2.0/24"] # Replace with Asia VPC subnet

  depends_on = [
    google_compute_forwarding_rule.rule_esp_fw,
    google_compute_forwarding_rule.rule_udp_500,
    google_compute_forwarding_rule.rule_udp_4500
  ]
}

# Internal Traffic Firewall Rule for Europe
resource "google_compute_firewall" "allow_internal_traffic_europe" {
  name    = "allow-internal-traffic-europe"
  network = google_compute_network.hq_vpc.id

  allow {
    protocol = "all"
  }

  source_ranges = ["192.168.2.0/24"] # Replace with Asia VPC subnet
  description   = "Allow all internal traffic from Asia VPC"
}



########################### VPN REMOTE ##########################################

# Gateway (VPN Gateway):
resource "google_compute_vpn_gateway" "asia_vpn_gateway" {
  name       = "asia-vpn-gateway"
  network    = google_compute_network.hq_vpc.id
  region     = var.region_2
  depends_on = [google_compute_subnetwork.asia_subnet]
}


# Static IP
resource "google_compute_address" "asia_static_ip" {
  name   = "region-2-static-ip"
  region = var.region_2
}



# Forwarding Rule for ESP traffic
resource "google_compute_forwarding_rule" "rule_esp" {
  name        = "rule-esp"
  region      = var.region_2
  ip_protocol = "ESP"
  ip_address  = google_compute_address.asia_static_ip.address
  target      = google_compute_vpn_gateway.asia_vpn_gateway.self_link
  # project = var.project_id
}


# Forwarding Rule for UDP Port 500 traffic
resource "google_compute_forwarding_rule" "rule_udp500" {
  name        = "rule-udp500"
  region      = var.region_2
  ip_protocol = "UDP"
  ip_address  = google_compute_address.asia_static_ip.address
  port_range  = "500"
  target      = google_compute_vpn_gateway.asia_vpn_gateway.self_link
}



# Forwarding Rule for UDP Port 4500 traffic
resource "google_compute_forwarding_rule" "rule_udp4500" {
  name        = "rule-udp4500"
  region      = var.region_2
  ip_protocol = "UDP"
  ip_address  = google_compute_address.asia_static_ip.address
  port_range  = "4500"
  target      = google_compute_vpn_gateway.asia_vpn_gateway.self_link
}



# Tunnel remote asia to europe hq
resource "google_compute_vpn_tunnel" "asia_to_europe_tunnel" {
  name                    = "asia-to-europe-tunnel"
  target_vpn_gateway      = google_compute_vpn_gateway.asia_vpn_gateway.self_link
  peer_ip                 = google_compute_address.eu_static_ip.address
  shared_secret           = "Lawstask" # Replace with your shared secret
  ike_version             = 2
  local_traffic_selector  = ["192.168.2.0/24"] # Replace with Asia VPC subnet
  remote_traffic_selector = ["10.108.10.0/24"] # Replace with Europe VPC subnet

  depends_on = [
    google_compute_forwarding_rule.rule_esp,
    google_compute_forwarding_rule.rule_udp500,
    google_compute_forwarding_rule.rule_udp4500
  ]
}