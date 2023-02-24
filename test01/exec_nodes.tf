resource "openstack_compute_instance_v2" "exec-node" {

  count           = "${var.exec_node_count}"
  name            = "${var.name_prefix}exec-node-${count.index}${var.name_suffix}"
  flavor_name     = "${var.flavors["exec-node"]}"
  image_id        = "${data.openstack_images_image_v2.vgcn-image.id}"
  key_pair        = "${openstack_compute_keypair_v2.my-cloud-key.name}"
  security_groups = "${var.secgroups}"
  # authorized_keys = [chomp(tls_private_key.ssh.public_key_openssh)]

  network {
    uuid = "${data.openstack_networking_network_v2.internal.id}"
  }

  user_data = <<-EOF
    #cloud-config
    write_files:
    - content: |
        CONDOR_HOST = localhost
        ALLOW_WRITE = *
        ALLOW_READ = $(ALLOW_WRITE)
        ALLOW_ADMINISTRATOR = *
        ALLOW_NEGOTIATOR = $(ALLOW_ADMINISTRATOR)
        ALLOW_CONFIG = $(ALLOW_ADMINISTRATOR)
        ALLOW_DAEMON = $(ALLOW_ADMINISTRATOR)
        ALLOW_OWNER = $(ALLOW_ADMINISTRATOR)
        ALLOW_CLIENT = *
        DAEMON_LIST = MASTER, SCHEDD, STARTD
        FILESYSTEM_DOMAIN = vgcn
        UID_DOMAIN = vgcn
        TRUST_UID_DOMAIN = True
        SOFT_UID_DOMAIN = True
        # run with partitionable slots
        CLAIM_PARTITIONABLE_LEFTOVERS = True
        NUM_SLOTS = 1
        NUM_SLOTS_TYPE_1 = 1
        SLOT_TYPE_1 = 100%
        SLOT_TYPE_1_PARTITIONABLE = True
        ALLOW_PSLOT_PREEMPTION = False
        STARTD.PROPORTIONAL_SWAP_ASSIGNMENT = True
      owner: root:root
      path: /etc/condor/condor_config.local
      permissions: '0644'
    - content: |
        /data           /etc/auto.data          nfsvers=3
      owner: root:root
      path: /etc/auto.master.d/data.autofs
      permissions: '0644'
    - content: |
        share  -rw,hard,intr,nosuid,quota  ${openstack_compute_instance_v2.nfs-server.access_ip_v4}:/data/share
      owner: root:root
      path: /etc/auto.data
      permissions: '0644'
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC49BanKDSkoT22TWvNeL+4x/qcRi0a7Nuf+GmDXEEaCWlhvD7oeYoqVm/Jbbxo0FSDENwpMds5nR8MrdInOL1Ycp9sOoOsi0Sf1mMKhErHE2O+SHmQrPiKphams3wNSllKV80171E+7+ljYcUPREybBomZgYWlqeh46q+41AEFWxn6MYlQud/pa7TTnu/1egaWhX5W+P3l9Mo+x13LOywqbTl+545gvKg2bAHdkFkj/k/YKqM/DSFXT4Cx2r/OWZuR6oBLvsjmsld6rUdDhgIKqxQgK523NJv2gm0TS2JBXzFLsnH+ByIF55r1VCQlhYqfbl0w1O6exbc7pUnRy+ch
    runcmd:
    - [sh, -xc, sed -i 's|nameserver 10.0.2.3||g' /etc/resolv.conf]
    - [sh, -xc, sed -i 's|localhost.localdomain|$(hostname -f)|g' /etc/telegraf/telegraf.conf]
    - [systemctl, restart, telegraf]
    - curl -fsSL "https://get.htcondor.org" | sudo GET_HTCONDOR_PASSWORD="123456" /bin/bash -s -- --no-dry-run --execute localhost
  EOF
}
