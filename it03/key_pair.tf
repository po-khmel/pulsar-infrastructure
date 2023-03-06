resource "openstack_compute_keypair_v2" "my-cloud-key" {
  name       = "${var.public_key["name"]}"
  public_key = "${var.public_key["pubkey"]}"
}

resource "tls_private_key" "intra-vgcn-key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

# resource "local_file" "private_key" {
#   content         = tls_private_key.intra-vgcn-key.private_key_pem
#   filename        = "vgcn.key"
#   file_permission = "0644"
# }