terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {}

variable "passwd" {
  type = string

  # password = adminadmin
  default = "$6$rounds=4096$i0Fj2b1bir$exch.dAJADlVgwZ9VyBBx2Pm1n52ew75Im4f5CXqcYCFlELQVUOmKHJ/aVlGEUvJQPxWqzOfsoX.LrF0xSEVG/"
}

resource "digitalocean_ssh_key" "testing" {
  name       = "DigitalOcean Droplet Default Example"
  public_key = local.public_key
}

module "droplet" {
  source = "../.."

  depends_on = [
    digitalocean_ssh_key.testing
  ]

  name          = "droplet"
  image         = "ubuntu-21-10-x64"
  droplet_agent = true

  ssh_port              = 8008
  ssh_permit_root_login = false

  stub_key_name = digitalocean_ssh_key.testing.name

  user_data = {
    users = [
      {
        name   = "devops"
        sudo   = "ALL=(ALL) NOPASSWD:ALL"
        shell  = "/bin/bash"
        passwd = var.passwd

        ssh_authorized_keys = [
          local.public_key
        ]
      }
    ]

    write_files = [
      {
        encoding    = "gz+b64"
        owner       = "root:root"
        path        = "/tmp/test-content.txt"
        permissions = "0644"
        content     = base64gzip(local.test_content)
      }
    ]

    runcmd = [
      "mkdir /tmp/hello",
      "echo 'Hello world' > /tmp/hello/test.txt",
      "python3 -m http.server -d /tmp/hello ${local.server_port}"
    ]
  }
}

resource "digitalocean_firewall" "web_traffic" {
  name = "web-traffic"

  droplet_ids = [module.droplet.info.id]

  inbound_rule {
    protocol         = local.tcp_protocol
    port_range       = local.server_port
    source_addresses = local.any_ip
  }

  inbound_rule {
    protocol         = local.tcp_protocol
    port_range       = local.ssh_port
    source_addresses = local.any_ip
  }

  inbound_rule {
    protocol         = local.icmp_protocol
    source_addresses = local.any_ip
  }

  outbound_rule {
    protocol              = local.tcp_protocol
    port_range            = local.all_ports
    destination_addresses = local.any_ip
  }
}

locals {
  tcp_protocol  = "tcp"
  icmp_protocol = "icmp"
  server_port   = "8000"
  ssh_port      = "8008"
  all_ports     = "1-65535"
  any_ip        = ["0.0.0.0/0", "::/0"]
  public_key    = file("./files/testing.pub")
  test_content  = file("./files/test-content.txt")
}

output "info" {
  value = module.droplet.info
}
