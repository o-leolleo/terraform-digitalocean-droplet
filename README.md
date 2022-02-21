## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_ssh_key.stub](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backups"></a> [backups](#input\_backups) | n/a | `bool` | `false` | no |
| <a name="input_droplet_agent"></a> [droplet\_agent](#input\_droplet\_agent) | n/a | `bool` | `false` | no |
| <a name="input_image"></a> [image](#input\_image) | n/a | `string` | n/a | yes |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | n/a | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"nyc1"` | no |
| <a name="input_resize_disk"></a> [resize\_disk](#input\_resize\_disk) | n/a | `bool` | `false` | no |
| <a name="input_size"></a> [size](#input\_size) | n/a | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_ssh_permit_root_login"></a> [ssh\_permit\_root\_login](#input\_ssh\_permit\_root\_login) | n/a | `bool` | `false` | no |
| <a name="input_ssh_port"></a> [ssh\_port](#input\_ssh\_port) | n/a | `number` | `22` | no |
| <a name="input_stub_key_name"></a> [stub\_key\_name](#input\_stub\_key\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | n/a | `any` | `null` | no |
| <a name="input_vpc_uuid"></a> [vpc\_uuid](#input\_vpc\_uuid) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_info"></a> [info](#output\_info) | Same set of attributes as https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet#attributes-reference |
