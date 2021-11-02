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
      v.customize ["modifyvm", :id, "--memory", 3072]
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

  # Serveur bdd PostgreSQL
  config.vm.define "p1srvbddpg" do |srvbdd|
    srvbdd.vm.box = "debian/bullseye64"
    srvbdd.vm.hostname = "p1srvbddpg"
    srvbdd.vm.box_url = "debian/bullseye64"
    srvbdd.vm.network :private_network, ip: "172.16.1.6"
    srvbdd.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "p1srvbddpg"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    srvbdd.vm.provision "shell", path: "config_p1ssh.sh"
    srvbdd.vm.provision "shell", path: "install_p1srvpostgres.sh"
  end


  # Serveur bdd MySQL
  config.vm.define "p1srvbddmysql" do |srvbdd|
    srvbdd.vm.box = "debian/bullseye64"
    srvbdd.vm.hostname = "p1srvbddmysql"
    srvbdd.vm.box_url = "debian/bullseye64"
    srvbdd.vm.network :private_network, ip: "172.16.1.7"
    srvbdd.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "p1srvbddmysql"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    srvbdd.vm.provision "shell", path: "config_p1ssh.sh"
    srvbdd.vm.provision "shell", path: "install_p1srvmysql.sh"
  end

  # Serveur registry
  config.vm.define "p1registry" do |registry|
    registry.vm.box = "debian/bullseye64"
    registry.vm.hostname = "p1registry"
    registry.vm.box_url = "debian/bullseye64"
    registry.vm.network :private_network, ip: "172.16.1.8"
    registry.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "p1registry"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    registry.vm.provision "shell", path: "config_p1ssh.sh"
    registry.vm.provision "shell", path: "install_p1registry.sh"
  end

end