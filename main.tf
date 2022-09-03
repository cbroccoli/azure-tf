provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name = "terrform-subnet1"
  ip_cidr_range = "10.254.0.0/16"
  region = "us-central1"
  network = google_compute_network.vpc_network.self_link
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance1"
  machine_type = var.machine_types["dev"]
  tags = ["managment-host"]

  provisioner "local-exec" {
    command = "echo ${google_compute_instance.vm_instance.name}:  ${google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip} >> ip_address.txt"
  }

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork.self_link
  access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
}

resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}


