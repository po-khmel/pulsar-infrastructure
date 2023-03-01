output "node_name" {
  value = "${openstack_compute_instance_v2.central-manager.name}"
}

output "ip_v4_internal" {
  value = "${openstack_compute_instance_v2.central-manager.network.0.fixed_ip_v4}"
}

//output "ip_v4_public" {
//  value = "${openstack_compute_instance_v2.central-manager.0.access_ip_v4}"
//}
//
output "floating_IP" {
  value = "${openstack_networking_floatingip_v2.myip.address}"
}

output "name" {
  "make a list of all exec node IPv4 adresses"
}

resource "local_file" "private_key" {
  content         = tls_private_key.intra-vgcn-key.private_key_pem
  filename        = "vgcn.key"
  file_permission = "0600"
}