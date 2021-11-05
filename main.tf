// Configure the Google Cloud provider
provider "google" {
 project     = "playground-s-11-d15cfb82"
 region      = "us-central1"
}
// Create VPC
resource "google_compute_network" "vpc" {
 name                    = "test-network"
 auto_create_subnetworks = "false"
}

// Create Subnet
resource "google_compute_subnetwork" "subnet" {
 name          = "test-subnetwork"
 ip_cidr_range = "192.168.1.0/24"
 network       = google_compute_network.vpc.id
 region      = "us-central1"
}

// VPC firewall configuration
resource "google_compute_firewall" "firewall" {
  name    = "dnmn-firewall"
  network = google_compute_network.vpc.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
