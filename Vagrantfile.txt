Vagrant.configure("2") do |config|

if Vagrant.has_plugin? "vagrant-vbguest"
config.vbguest.no_install = true
config.vbguest.auto_update = false
config.vbguest.no_remote = true
end

config.vm.define :aprovFire do |aprovFire|
aprovFire.vm.box = "generic/centos8"
aprovFire.vm.network :private_network, ip: "192.168.50.20"
aprovFire.vm.provision "file", source: "script.sh", destination: "/home/vagrant/script.sh"
aprovFire.vm.provision "shell", path: "script.sh"
aprovFire.vm.hostname = "aprovFire"
end

config.vm.define :aprovStreama do |aprovStreama|
aprovStreama.vm.box = "generic/centos8"
aprovStreama.vm.network :private_network, ip: "192.168.50.33"
aprovStreama.vm.provision "file", source: "script_streama.sh", destination: "/home/vagrant/script_streama.sh"
aprovStreama.vm.provision "shell", path: "script_streama.sh"
aprovStreama.vm.hostname = "aprovStreama"
end
end