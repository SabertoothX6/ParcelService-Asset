Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 80, host: 8084
  config.vm.network "private_network", ip: "192.168.56.100",:name => 'vboxnet0',:adapter => 2
  config.vm.synced_folder "script/", "/home/vagrant/script"

  config.vm.provider "virtualbox" do |vb|
  vb.gui = false
  vb.name="asset-server"
  vb.memory = "512"
  end

  config.vm.provision "shell", run: "always", inline: <<-SHELL
  sudo apt-get update
  sudo apt-get upgrade -y
  SHELL

  config.vm.provision "shell", inline: <<-SHELL
  sudo apt-get install -y apache2
  mkdir js
  mkdir images
  mkdir script
  sudo sed -i 's#DocumentRoot /var/www/html#DocumentRoot /home/vagrant#g' /etc/apache2/sites-available/000-default.conf
  sudo sed -i 's#<Directory /var/www/>#<Directory /home/vagrant/>#g' /etc/apache2/apache2.conf
  sudo service apache2 restart
  sudo chown vagrant: js
  sudo chown vagrant: images
  sudo chown vagrant: script
  SHELL

config.vm.provision "docker" do |d|
  end

config.vm.provision "shell", inline: <<-SHELL
docker run -d -p 5000:5000 -v /var/lib/docker/registry-data/:/var/lib/docker/registry-data/ --restart=always --name=registrydev registry
SHELL
end
