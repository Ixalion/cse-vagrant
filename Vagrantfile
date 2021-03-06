# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "dreamscapes/archlinux"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./shared", "/home/vagrant/shared"
  config.vm.synced_folder "./workspace", "/home/vagrant/workspace"
  config.vm.synced_folder "./grader_scripts", "/home/vagrant/grader_scripts"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Set the system to only be able to consume 75% of the cpu.
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "75"]

    # Make the system dual core.
    vb.cpus = 2

    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end

  config.vm.provision "bootstrap", type: "shell", path: "./.vagrant_scripts/bootstrap.sh"

  config.vm.provision "workspace", type: "shell", path: "./.vagrant_scripts/workspace.sh"

  config.vm.provision "eclipse", type: "shell", path: "./.vagrant_scripts/eclipse.sh"

  config.vm.provision "restart", type: "shell", path: "./.vagrant_scripts/restart.sh"

end
