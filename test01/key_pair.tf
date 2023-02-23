resource "openstack_compute_keypair_v2" "my-cloud-key" {
  name       = "${var.public_key["name"]}"
  public_key = "${var.public_key["pubkey"]}"
}

resource "tls_private_key" "intra-vgcn-key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "random_password" "condor-password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}