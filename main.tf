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

# Pull the Nginx image from Docker Hub
resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

# Start a container
resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.name
  ports {
    internal = 1880
    external = 1880
  }
}


# Start a container
resource "docker_container" "nginx_image" {
  count = 2
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nginx_image.name
  ports {
    internal = 8080
    external = 8080
  }
}

resource "random_string" "random" {
  count   = 2
  length  = 4
  special = false
  upper   = false
}

