terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

# Image
resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

# Start a container
resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.name  

  ports {
    internal = 1880
    external = 1880
  }

  # Specify the network mode for the container
  network_mode = "bridge"
}

output "Ip-Address" {
  value = docker_container.nodered_container.ip_address
  description = "IP address of the container"
  
}
output "container-name" {
  value = docker_container.nodered_container.name
  description = "Container name"
  
}
