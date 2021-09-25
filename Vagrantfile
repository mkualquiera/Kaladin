# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

allvars = YAML.load_file("bootstrap/environments/development/group_vars/all")

Vagrant.configure("2") do |config|
  
  config.vm.box = "archlinux/archlinux"

  config.vm.define "ldap" do |machine|
    machine.vm.network "private_network", ip: "192.168.1.9",
                      virtualbox__intnet: "internal"
    machine.vm.network "private_network", ip: "192.168.2.9",
                      virtualbox__intnet: "nfs"

    machine.vm.hostname = "ldap.kaladin.local"

    machine.vm.provision :shell, path: "bootstrap_node.sh", privileged: true
  
    machine.vm.provider "virtualbox" do |v|
      v.cpus = 1
      v.name = "ldap"
    end
  end

  config.vm.define "nas" do |machine|
    machine.vm.network "private_network", ip: "192.168.1.8",
                      virtualbox__intnet: "internal"
    machine.vm.network "private_network", ip: "192.168.2.8",
                      virtualbox__intnet: "nfs"

    machine.vm.hostname = "nas.kaladin.local"

    machine.vm.provision :shell, path: "bootstrap_node.sh", privileged: true
  
    machine.vm.provider "virtualbox" do |v|
      v.cpus = 1
      v.name = "nas"
    end
  end

  (1..allvars["num_computes"]).each do |i|
    ip_host = 10 + i

    config.vm.define "compute-#{i}" do |machine|
      machine.vm.network "private_network", ip: "192.168.1.#{ip_host}",
                        virtualbox__intnet: "internal"
      machine.vm.network "private_network", ip: "192.168.2.#{ip_host}",
                        virtualbox__intnet: "nfs"

      machine.vm.hostname = "compute-#{i}.kaladin.local"

      machine.vm.provision :shell, path: "bootstrap_node.sh", privileged: true
    
      machine.vm.provider "virtualbox" do |v|
        v.cpus = 1
        v.name = "compute-#{i}"
      end
    end
  end

  config.vm.define "radiant" do |machine|
    machine.vm.network "private_network", ip: "192.168.1.10",
                      virtualbox__intnet: "internal"
    machine.vm.network "private_network", ip: "192.168.2.10",
                      virtualbox__intnet: "nfs"

    machine.vm.hostname = "radiant.kaladin.local"

    machine.vm.provision :shell, path: "bootstrap_master.sh", privileged: true
  
    machine.vm.provider "virtualbox" do |v|
      v.cpus = 1
      v.name = "radiant"
    end
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
  end

end
