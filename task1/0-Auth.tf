#Provider configuration for Google Cloud Platform
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.85.0"
    }
  }
}

provider "google" {
  # Configuration options
  project     = "gcp-class-416401"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "gcp-class-416401-cca735711e22.json"
}