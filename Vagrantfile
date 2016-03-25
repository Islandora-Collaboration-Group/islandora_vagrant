# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$cpus   = ENV.fetch("ISLANDORA_VAGRANT_CPUS", "2")
$memory = ENV.fetch("ISLANDORA_VAGRANT_MEMORY", "3000")
$hostname = ENV.fetch("ISLANDORA_VAGRANT_HOSTNAME", "islandora")
$forward = ENV.fetch("ISLANDORA_VAGRANT_FORWARD", "TRUE")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  config.vm.provider "virtualbox" do |v|
    v.name = "Islandora 7.x-1.x Development VM"
  end

  config.vm.hostname = $hostname

  # In March 2016 numerous attempts were made to give this VM a network interface that would
  # allow it to communicate with an existing, persistent, test repository.  All failed for
  # one reason or another, but the attempts are preserved here so that others can see what's
  # been tried.
  #
  # MAM - This configuration, created 22-March-2016 allows RepositoryX to PING the VM!  But this won't work with my VPN connection!
  # config.vm.network "public_network", ip: "132.161.216.192", netmask: "255.255.0.0", bridge: "en5: AX88179 USB 3.0 to Gigabit Ethernet"
  #
  # MAM - Line below added to provide a public network interface on 18-March-2016 per https://www.vagrantup.com/docs/networking/public_network.html
  #a config.vm.network "public_network"
  # MAM - Line below added to provide a public network interface on 18-March-2016 per http://serverfault.com/questions/539251/vagrant-public-ip-not-accessible
  #b config.vm.network :public_network, ip: '132.161.216.234', :netmask => '255.255.0.0', :bridge => 'eth1'
  #c config.vm.network :public_network
  #
  # MAM - The following from https://akrabat.com/sharing-host-vpn-with-vagrant/
  #d config.vm.network :private_network
  #d config.vm.provider :virtualbox do |vb|
  #d     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  #d end
  #

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "islandora/islandora-base"

  unless  $forward.eql? "FALSE"  
    config.vm.network :forwarded_port, guest: 8080, host: 8080 # Tomcat
    config.vm.network :forwarded_port, guest: 3306, host: 3306 # MySQL
    config.vm.network :forwarded_port, guest: 8000, host: 8000 # Apache
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", $memory]
    vb.customize ["modifyvm", :id, "--cpus", $cpus]
  end

  shared_dir = "/vagrant"

  config.vm.provision :shell, path: "./scripts/islandora_modules.sh", :args => shared_dir, :privileged => false
  config.vm.provision :shell, path: "./scripts/islandora_libraries.sh", :args => shared_dir, :privileged => false
  if File.exist?("./scripts/custom.sh") then
    config.vm.provision :shell, path: "./scripts/custom.sh", :args => shared_dir
  end
  config.vm.provision :shell, path: "./scripts/post.sh"
end
