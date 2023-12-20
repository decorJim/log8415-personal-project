#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

IP_ADDRESS=$1

sudo apt-get update -y
sudo apt-get install sysbench -y
sudo apt-get install libclass-methodmaker-perl -y
sudo wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb
sudo touch /etc/my.cnf
echo "[mysql_cluster]" | sudo tee -a /etc/my.cnf
echo "ndb-connectstring=ip-${IP_ADDRESS//./-}.ec2.internal" | sudo tee -a /etc/my.cnf
source /etc/my.cnf
sudo mkdir -p /usr/local/mysql/data
sudo mkdir -p /etc/systemd/system/
sudo touch /etc/systemd/system/ndbd.service
echo "[Unit]" | sudo tee -a /etc/systemd/system/ndbd.service
echo "Description=MySQL NDB Data Node Daemon" | sudo tee -a /etc/systemd/system/ndbd.service
echo "After=network.target auditd.service" | sudo tee -a /etc/systemd/system/ndbd.service
echo "[Service]" | sudo tee -a /etc/systemd/system/ndbd.service
echo "Type=forking" | sudo tee -a /etc/systemd/system/ndbd.service
echo "ExecStart=/usr/sbin/ndbd" | sudo tee -a /etc/systemd/system/ndbd.service
echo "ExecReload=/bin/kill -HUP $MAINPID" | sudo tee -a /etc/systemd/system/ndbd.service
echo "KillMode=process" | sudo tee -a /etc/systemd/system/ndbd.service
echo "Restart=on-failure" | sudo tee -a /etc/systemd/system/ndbd.service
echo "[Install]" | sudo tee -a /etc/systemd/system/ndbd.service
echo "WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/ndbd.service
source /etc/systemd/system/ndbd.service
sudo systemctl daemon-reload
sudo systemctl enable ndbd
sudo systemctl start ndbd
sudo touch status.ini
sudo systemctl status ndbd | sudo tee -a status.ini'