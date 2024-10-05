provider "google" {
  project = "my-project-279-436907"   # Replace with your project ID
  region  = "us-central1"        # Change if needed
  credentials = file("terraform.json")
}



resource "google_compute_instance" "web_server" {
  name         = "web-server-instance"
  machine_type = "f1-micro"       # Change if needed
  zone         = "us-central1-a"
  tags = ["http-server"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # Use your preferred OS
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y apache2  # Change to nginx if needed
    systemctl start apache2
    systemctl enable apache2
  EOT
}

output "external_ip" {
  value = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}
