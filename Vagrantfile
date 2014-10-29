# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu_14_04_cloud"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.define "web" do |web|
    web.vm.network "private_network", ip: "192.168.56.101"
    web.vm.hostname = "web.workshop.dev"

    web.vm.synced_folder "./", "/vagrant", id: "vagrant-root", :nfs => true

    web.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "web.workshop.dev"]
    end

    web.vm.provision :shell, :inline => 'apt-get update'

    web.vm.provision :puppet do |puppet|
      puppet.facter = {
        "ssh_username" => "vagrant"
      }

      puppet.manifest_file = "lnmp_client.pp"
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.options = ["--verbose"]
    end

  end # end web

  config.vm.define "db" do |db|
    db.vm.network "private_network", ip: "192.168.56.102"
    db.vm.hostname = "db.workshop.dev"

    db.vm.synced_folder "./", "/vagrant", id: "vagrant-root", :nfs => true

    db.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "db.workshop.dev"]
    end

    db.vm.provision :shell, :inline => 'apt-get update'

    db.vm.provision :puppet do |puppet|
      puppet.facter = {
        "ssh_username" => "vagrant"
      }

      puppet.manifest_file = "lnmp_server.pp"
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.options = ["--verbose"]
    end
  end # end db

end # end config
