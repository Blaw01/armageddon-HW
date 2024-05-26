
# VPC and Subnetwork for Europe Headquarters
variable "subnet_hq" {
  type        = string
  description = "The name of the first subnet"
  default     = "laws-europe-subnet1"
}


variable "hq_region" {
  type        = string
  description = "The region for hq"
  default     = "europe-west1"
}

variable "hq_zone" {
  type        = string
  description = "The region for hq"
  default     = "europe-west1-b"
}


variable "hq_cidr_range" {
  type        = string
  description = "IP CIDR range for the EU HQ subnet"
  default     = "10.108.10.0/24"
}


# Global Address for HQ to Remote VPC Peering
variable "hq-to-remote-address" {
  type        = string
  description = "Name of the global address for the HQ to Remote VPC peering connection"
  default     = "europe-to-americas-address"
}

# Network Peering: Remote to HQ
variable "remote_to_hq_peer" {
  type        = string
  description = "String representing the peering from Remote to HQ"
  default     = "america-to-europe-peer"
}


###################################### REMOTE #################################################


# Remote Subnet Variables
variable "subnet_1" {
  type        = string
  description = "Name of the first subnet for the Americas Network."
  default     = "america-subnet1"
}

variable "ip_cidr_range2" {
  type        = string
  description = "IP CIDR range for the first subnet of the Americas Network."
  default     = "172.16.3.0/24"
}

variable "region1" {
  type        = string
  description = "The region where the first subnet resources will be deployed."
  default     = "us-east1"
}

variable "subnet_2" {
  type        = string
  description = "Name of the second subnet for the Americas Network."
  default     = "america-subnet2"
}

variable "ip_cidr_range3" {
  type        = string
  description = "IP CIDR range for the second subnet of the Americas Network."
  default     = "172.16.4.0/24"
}

variable "region2" {
  type        = string
  description = "The region where the second subnet resources will be deployed."
  default     = "us-central1"
}

# Project and Global Address Variables

variable "remote-to-hq-address-1" {
  type        = string
  description = "Name of the global address for the Remote to HQ VPC peering connection."
  default     = "americas-to-europe-address"
}

# Peering Configuration Variables

variable "hq_to_remote_peer" {
  type        = string
  description = "String representing the peering from HQ to Remote."
  default     = "euro-to-america-peer"
}


variable "remote_to_hq_vpc_global_address" {
  type        = string
  description = "Global Address for Remote to HQ VPC Peering."
  default     = "americas-to-europe-address"
}

# Firewall Rule Variables

variable "allow_ssh" {
  type        = string
  description = "Firewall Rule to Allow SSH Traffic in Americas."
  default     = "allow-ssh"
}

variable "allow_port_80_americas" {
  type        = string
  description = "Firewall Rule to Allow Port 80 Traffic in Americas."
  default     = "allow-port-80-americas"
}




############################################# ASIA ###########################################


variable "asia_cidr_range" {
  description = "The CIDR range for the Asia VPC subnet"
  type        = string
  default     = "192.168.2.0/24"
}

variable "region_2" {
  description = "The region for the Asia VPC"
  type        = string
  default     = "asia-southeast1"
}



variable "subnet_asia" {
  type        = string
  description = "The name of the first subnet"
  default     = "asia-subnet"
}

