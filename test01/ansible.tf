data "template_file" "ansible-vars" {
  template = "${file("./ansible-vars.json.tpl")}"

  // populate the template variables with these values
  vars = {
    condor_password = "${random_password.condor-password.result}"
    condor_host = "${openstack_compute_instance_v2.central-manager.access_ip_v4}"
    condor_ip_list = "${openstack_compute_instance_v2.exec-node[0].access_ip_v4}"
  }
}