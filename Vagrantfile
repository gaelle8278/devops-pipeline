# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # p1jenkins server
  config.vm.define "p1jenkins" do |jenkins|
    jenkins.vm.box = "debian/bullseye64"
    jenkins.vm.hostname = "p1jenkins"
    jenkins.vm.box_url = "debian/bullseye64"
    jenkins.vm.network :private_network, ip: "172.16.1.2"
    jenkins.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 4096]
      v.customize ["modifyvm", :id, "--name", "p1jenkins"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
    end
    jenkins.vm.provision "shell", path: "config_p1ssh.sh"
    jenkins.vm.provision "shell", path: "install_p1jenkins.sh"
  end

  # p1 serveur dev
  config.vm.define "p1srvdev" do |srvdev|
    srvdev.vm.box = "debian/bullseye64"
    srvdev.vm.hostname = "p1srvdev"
    srvdev.vm.box_url = "debian/bullseye64"
    srvdev.vm.network :private_network, ip: "172.16.1.3"
    srvdev.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "p1srvdev"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    srvdev.vm.provision "shell", path: "config_p1ssh.sh"
  end 

   # serveur stage/recette
   config.vm.define "p1srvstage" do |srvstage|
    srvstage.vm.box = "debian/bullseye64"
    srvstage.vm.hostname = "p1srvstage"
    srvstage.vm.box_url = "debian/bullseye64"
    srvstage.vm.network :private_network, ip: "172.16.1.4"
    srvstage.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "p1srvstage"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    srvstage.vm.provision "shell", path: "config_p1ssh.sh"
  end

  # serveur prod
  config.vm.define "p1srvprod" do |srvprod|
    srvprod.vm.box = "debian/bullseye64"
    srvprod.vm.hostname = "p1srvprod"
    srvprod.vm.box_url = "debian/bullseye64"
    srvprod.vm.network :private_network, ip: "172.16.1.5"
    srvprod.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "p1srvprod"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    srvprod.vm.provision "shell", path: "config_p1ssh.sh"
  end

end