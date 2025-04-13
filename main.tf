provider "google" {
  project     = "gcp-dev-space"
  region      = "us-central1"
  credentials = file("terraform.json")
}

resource "google_compute_instance" "web_server" {
  name         = "web-server-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  tags         = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    systemctl start apache2
    systemctl enable apache2
  EOT
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

output "external_ip" {
  value = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}
