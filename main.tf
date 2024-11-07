# Specify the Docker provider with kreuzwerker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.21.0" # or latest stable version
    }
  }
}

# Configure the Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock" # For Linux/Ubuntu
}

# Pull the latest MySQL Docker image
resource "docker_image" "mysql" {
  name = "mysql:latest"
}

# Define the MySQL Docker container
resource "docker_container" "mysql_container" {
  name  = "mysql-container"
  image = docker_image.mysql.image_id

  # Environment variables for MySQL setup
  env = [
    "MYSQL_ROOT_PASSWORD=rootpassword",
    "MYSQL_DATABASE=mydatabase",
    "MYSQL_USER=myuser",
    "MYSQL_PASSWORD=mypassword",
  ]

  # Expose MySQL on port 3306
  ports {
    internal = 3306
    external = 3306
  }

  # Mount the SQL file to initialize the database on startup
  volumes {
    host_path      = "${abspath(path.module)}/init.sql"
    container_path = "/docker-entrypoint-initdb.d/init.sql"
  }
}
