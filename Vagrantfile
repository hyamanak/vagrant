Vagrant.configure("2") do |config|
  config.vm.box = "fedora/39-cloud-base"
  config.vm.box_check_update = false

  # Ansible コントローラー
  config.vm.define "ansible" do |ansible|
    ansible.vm.hostname = "ansible"
    ansible.vm.network "private_network", ip: "192.168.57.3"
    ansible.vm.provider "virtualbox" do |vb|
      vb.name = "ansible"
      vb.memory = 2048
      vb.cpus = 2
    end
    ansible.vm.provision "shell", path: "provisioning/setup-ansible.sh"
  end

  # AWX ノード（あとで AWX Operator を自動インストール予定）
  config.vm.define "awx" do |awx|
    awx.vm.hostname = "awx"
    awx.vm.network "private_network", ip: "192.168.57.4"
    awx.vm.provider "virtualbox" do |vb|
      vb.name = "awx"
      vb.memory = 4096
      vb.cpus = 2
    end
    awx.vm.provision "shell", path: "provisioning/setup-awx.sh"
  end

  # マネージドノード3台（.10～.12）
  (1..3).each do |i|
    config.vm.define "managed#{i}" do |node|
      node.vm.hostname = "managed#{i}"
      node.vm.network "private_network", ip: "192.168.57.#{9+i}"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "managed#{i}"
        vb.memory = 1024
        vb.cpus = 1
      end
      node.vm.provision "shell", path: "provisioning/setup-managed.sh"
    end
  end
end
