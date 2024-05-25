
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