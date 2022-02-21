terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.10"
    }
  }
}

resource "digitalocean_droplet" "this" {
  image         = var.image
  name          = var.name
  region        = var.region
  size          = var.size
  backups       = var.backups
  monitoring    = var.monitoring
  vpc_uuid      = var.vpc_uuid
  resize_disk   = var.resize_disk
  tags          = var.tags
  droplet_agent = var.droplet_agent

  ssh_keys = [
    data.digitalocean_ssh_key.stub.id,
  ]

  user_data = join("\n", [
    "#cloud-config",
    yamlencode(merge(var.user_data, {
      write_files = concat(try(var.user_data.write_files, []), [{
        encoding    = "gz+b64"
        owner       = "root:root"
        path        = "/etc/ssh/sshd_config"
        permissions = "0644"
        content     = base64gzip(local.user_data)
      }])
    })),
  ])
}

data "digitalocean_ssh_key" "stub" {
  name = var.stub_key_name
}

locals {
  user_data = templatefile("${path.module}/templates/sshd_config", {
    ssh_port              = var.ssh_port
    ssh_permit_root_login = var.ssh_permit_root_login
  })
}
