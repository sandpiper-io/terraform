provider "carina" {
  username = "${var.carina_username}"
  api_key = "${var.carina_api_key}"
}

resource "carina_cluster" "test" {
  name = "${var.cluster_name}"
}

provider "docker" {
  host = "${carina_cluster.test.docker_host}"
  cert_path = "${carina_cluster.test.docker_cert_path}"
}

# Create the network for our system
resource "docker_network" "mynetwork" {
    name = "${var.network_name}"
}

# Create, start, and initialize the database
resource "docker_container" "mysql" {
    image = "${docker_image.mysql.latest}"
    name = "mysql"
    networks = ["${docker_network.mynetwork.name}"]
    env = [
        "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
        "MYSQL_DATABASE=${var.mysql_database}",
        "MYSQL_USER=${var.mysql_user}",
        "MYSQL_PASSWORD=${var.mysql_password}",
    ]
    provisioner "local-exec" {
        command = "docker run --rm \\
          --net ${docker_network.mynetwork.name} \\
          --env MYSQL_HOST=${var.mysql_host} \\
          --env MYSQL_PORT=${var.mysql_port} \\
          --env MYSQL_DATABASE=${var.mysql_database} \\
          --env MYSQL_USER=${var.mysql_user} \\
          --env MYSQL_PASSWORD=${var.mysql_password} \\
          carinamarina/guestbook-mysql \\
          python app.py create_tables"
    }
}

# Create and start the app server
resource "docker_container" "guestbook" {
    image = "${docker_image.guestbook.latest}"
    name = "guestbook"
    networks = ["${docker_network.mynetwork.name}"]
    env = [
        "MYSQL_HOST=${var.mysql_host}",
        "MYSQL_PORT=${var.mysql_port}",
        "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
        "MYSQL_DATABASE=${var.mysql_database}",
        "MYSQL_USER=${var.mysql_user}",
        "MYSQL_PASSWORD=${var.mysql_password}",
    ]
    ports {
        internal = 5000,
        external = 5000
    }
    provisioner "local-exec" {
        command = "echo open http://$(docker port guestbook 5000) > open_guestbook.sh"
    }
}

resource "docker_image" "mysql" {
    name = "mysql:5.6"
}

resource "docker_image" "guestbook" {
    name = "carinamarina/guestbook-mysql"
}