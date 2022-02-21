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

locals {
  public_key   = file("./files/testing.pub")
  test_content = file("./files/test-content.txt")
}

resource "digitalocean_ssh_key" "testing" {
  name       = "DigitalOcean Droplet Default Example"
  public_key = local.public_key
}

module "mongodb" {
  source = "../.."

  depends_on = [
    digitalocean_ssh_key.testing
  ]

  name          = "mongodb"
  image         = "ubuntu-21-04-x64"
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
      "echo 'Hello world' > /tmp/test.txt"
    ]
  }
}


output "info" {
  value = module.mongodb.info
}
