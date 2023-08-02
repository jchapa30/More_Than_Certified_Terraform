terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  # Add the provider version here, or leave it empty for the latest version.
  # version = "x.x.x"
}

# Start a container
resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = "nodered/node-red:latest"
  ports {
    internal = 1880
    external = 1880
  }
  
  # Specify the network for the container
  network {
    name = "bridge"
  }
}
