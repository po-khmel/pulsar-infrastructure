variable "nfs_disk_size" {
  default = 300
}

variable "flavors" {
  type = map
  default = {
    "central-manager" = "m1.medium"
    "nfs-server" = "m1.medium"
    "exec-node" = "m1.xlarge"
    "gpu-node" = "m1.medium"
  }
}

variable "exec_node_count" {
  default = 2
}

variable "gpu_node_count" {
  default = 0
}

variable "image" {
  type = map
  default = {
    "name" = "vggp-v60-j224-e0d36d08062d-dev.raw"
    "image_source_url" = "https://usegalaxy.eu/static/vgcn/vggp-v60-j224-e0d36d08062d-dev.raw"  
    "container_format" = "bare"
    "disk_format" = "raw"
   }
}

variable "public_key" {
  type = map
  default = {
    name = "key_label"
	  pubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEgz4Q2Iy6rwmn2ol7gtRN7tcMyk7E8Q3Grrlyf+ck/E6Ik7GxIGnnAhBvlOF9drbuy7tUI3BpDl4+PHtL0ls3x0+GO/MOfb/YB+aww9C7n1TaXIsMoYYegxNRen+3Mnvze2CGFibjRcDiG+oy3X9ijkItF+NByl/fidzd8NRi49jHr3/LVJ1SR2uo3HFELlkaW7vWVw/u/QcApYSkm00VvUroafBgMlZr821/d076fqXDJMtRTf1Oggt7+k6jzTmQmKspEBh8zB29YAcQa24VgTLJ5mYyRJX+kqJE/Madoph2+obNmxm6CpmCjm9IuxigAD8yH/1pcwy2Yz8Bq61D Generated-by-Nova"
	}
}

variable "name_prefix" {
  default = "vgcn-"
}

variable "name_suffix" {
  default = ".usegalaxy.eu"
}

variable "secgroups_cm" {
  type = list
  default = [
    "vgcn-public-ssh",
    "vgcn-ingress-private",
    "vgcn-egress-public",
  ]
}

variable "secgroups" {
  type = list
  default = [
    "vgcn-ingress-private",
    "vgcn-egress-public",
  ]
}

variable "public_network" {
  default  = "floating-ip"

}

variable "private_network" {
  type = map
  default  = {
    name = "elixir-VM-net"
    subnet_name = "elixir-VM-subnet"
    cidr4 = "192.168.208.0/22 "
  }
}

variable "ssh-port" {
  default = "22"
}

variable "pvt_key" {}

variable "condor_pass" {}