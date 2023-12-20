#!/bin/bash
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <IP_ADDRESS_1> <IP_ADDRESS_2> <IP_ADDRESS_3> <IP_ADDRESS_4>"
    exit 1
fi

IP_ADDRESS_1=$1
IP_ADDRESS_2=$2
IP_ADDRESS_3=$3
IP_ADDRESS_4=$4

echo "IP1: $IP_ADDRESS_1, IP2: $IP_ADDRESS_2, IP3: $IP_ADDRESS_3, IP4 $IP_ADDRESS_4" | sudo tee -a clusterip.txt
sudo apt-get install libaio1 -y
sudo apt-get install unzip -y
sudo apt-get install libmecab2 -y
sudo apt-get install sysbench -y
sudo apt-get install libncurses5 -y
sudo apt-get install libtinfo5 -y
sudo wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-management-server_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-management-server_7.6.6-1ubuntu18.04_amd64.deb
sudo mkdir -p /var/lib/mysql-cluster
sudo touch /var/lib/mysql-cluster/config.ini
echo "[ndbd default]" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "NoOfReplicas=3" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "[ndb_mgmd]" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "hostname=ip-${IP_ADDRESS_1//./-}.ec2.internal" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "NodeId=1" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "datadir=/var/lib/mysql-cluster" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "[ndbd]" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "hostname=ip-${IP_ADDRESS_2//./-}.ec2.internal" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "NodeId=2" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "datadir=/usr/local/mysql/data" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "[ndbd]" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "hostname=ip-${IP_ADDRESS_3//./-}.ec2.internal" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "NodeId=3" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "datadir=/usr/local/mysql/data" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "[ndbd]" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "hostname=ip-${IP_ADDRESS_4//./-}.ec2.internal" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "NodeId=4" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "datadir=/usr/local/mysql/data" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "[mysqld]" | sudo tee -a /var/lib/mysql-cluster/config.ini
echo "hostname=ip-${IP_ADDRESS_1//./-}.ec2.internal" | sudo tee -a /var/lib/mysql-cluster/config.ini
source /var/lib/mysql-cluster/config.ini
sudo mkdir -p /etc/systemd/system/
sudo touch /etc/systemd/system/ndb_mgmd.service
echo "[Unit]" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "Description=NDB Cluster Management Server" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "After=network.target auditd.service" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "[Service]" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "Type=forking" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "ExecStart=/usr/sbin/ndb_mgmd -f /var/lib/mysql-cluster/config.ini" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "ExecReload=/bin/kill -HUP $MAINPID" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "KillMode=process" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "Restart=on-failure" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "[Install]" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
echo "WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/ndb_mgmd.service
source /etc/systemd/system/ndb_mgmd.service
sudo systemctl daemon-reload
sudo systemctl enable ndb_mgmd
sudo systemctl start ndb_mgmd
sudo touch status.ini
sudo systemctl status ndb_mgmd >> status.ini