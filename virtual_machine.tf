terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

resource "virtualbox_vm" "node" {
  count  = 1
  name   = format("node-%02d", count.index)
  image  = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20230607.0.0/providers/virtualbox.box"
  cpus   = 2
  memory = "512 mib"

  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet0"
  }
}

output "IPAddr" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}
