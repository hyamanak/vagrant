#!/bin/bash
set -eux

# 必要パッケージのインストール
dnf install -y ansible openssh-clients

# vagrantユーザーの鍵生成（もし未生成なら）
if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
  sudo -u vagrant ssh-keygen -t rsa -b 2048 -N "" -f /home/vagrant/.ssh/id_rsa
fi

# 全マネージドノードに鍵を配布（初期パスワード: vagrant）
for host in 192.168.57.10 192.168.57.11 192.168.57.12; do
  sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@$host
done
