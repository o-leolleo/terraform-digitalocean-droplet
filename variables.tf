variable "image" {
  type = string
}

variable "name" {
  type = string
}

variable "region" {
  type    = string
  default = "nyc1"
}

variable "size" {
  type    = string
  default = "s-1vcpu-1gb"
}

variable "backups" {
  type    = bool
  default = false
}

variable "monitoring" {
  type    = bool
  default = true
}

variable "vpc_uuid" {
  type    = string
  default = null
}

variable "resize_disk" {
  type    = bool
  default = false
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "droplet_agent" {
  type    = bool
  default = false
}

variable "user_data" {
  type    = any
  default = null
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "ssh_permit_root_login" {
  type    = bool
  default = false
}

variable "stub_key_name" {
  type = string
}
