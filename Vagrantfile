Vagrant.configure("2") do |config|
    config.vm.hostname = "azure-node"
    config.vm.box = "generic/centos7"
    config.vm.network "public_network", use_dhcp_assigned_default_route: true
    config.vm.synced_folder "terraform/", "/vagrant"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.name = "azure-node"
    end
    config.vm.provision "shell", path: "provisioner.sh"
  end