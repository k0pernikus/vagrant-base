# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu_14_04_cloud"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.hostname = "workshop.dev"

  config.vm.network "private_network", ip: "192.168.56.101"

  config.vm.synced_folder "./", "/vagrant", id: "vagrant-root", :nfs => true

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--name", "workshopbox"]
  end

  if Vagrant.has_plugin?("vagrant_librarian_puppet")
    config.librarian_puppet.puppetfile_dir = "puppet/vendor"
    config.librarian_puppet.placeholder_filename = ".gitkeep"
  end

  config.vm.provision :shell, :inline => 'apt-get update'

  config.vm.provision :puppet do |puppet|
    puppet.manifest_file = "lamp.pp"
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = ["puppet/modules", "puppet/vendor/modules"]
    puppet.options = ["--verbose"]
  end
end
