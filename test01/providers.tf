# provider "openstack" {version = "1.22.0"}
terraform {
required_version = ">= 1.3.9"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.22.0"
    }
  }
}