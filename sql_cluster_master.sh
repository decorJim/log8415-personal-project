#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
      
sudo apt-get install python3-pip -y
sudo pip3 install flask

sudo mkdir app
cd app
git clone https://github.com/decorJim/log8415-personal-project
mv /app/log8415-personal-project/check.sh /app/

echo "from flask import Flask,request
import requests
import subprocess
import os

app = Flask(__name__)

ip1 = None
ip2 = None
ip3 = None
ip4 = None

@app.route('/health')
def health_check():
  # If everything is fine, return a 200 OK response when ping http://your-instance-ip:80/health
  command = f'echo "12345678" > test.txt'
  result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
  return 'OK', 200

@app.route('/benchmarks')
def benchmarks():
  script = f'sudo bash /app/check.sh {ip1}'
  script_file_path = 'file.txt'
  result = subprocess.run(script, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
  with open(script_file_path, 'w') as script_file:
      script_file.write(result.stdout)
      script_file.write(f'Script Errors:\n{result.stderr}')
  return result.stdout, 200

@app.route('/run_command', methods=['POST'])
def run_command():
  global ip1, ip2, ip3, ip4

  # Get IP addresses from the request
  ip1 = request.form.get('ip1')
  ip2 = request.form.get('ip2')
  ip3 = request.form.get('ip3')
  ip4 = request.form.get('ip4')

  os.chdir('/')

  master_ip_parts=ip1.split('.')
  slave_1_parts=ip2.split('.')
  slave_2_parts=ip3.split('.')
  slave_3_parts=ip4.split('.')

  commands=[
     f'echo "IP1: {ip1}, IP2: {ip2}, IP3: {ip3}, IP4 {ip4}" > clusterip.txt',
     'apt-get install libaio1 -y',
     'apt-get install unzip -y',
     'apt-get install libmecab2 -y',
     'apt-get install sysbench -y',
     'apt-get install libncurses5 -y',
     'apt-get install libtinfo5 -y',
     'wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-management-server_7.6.6-1ubuntu18.04_amd64.deb',
     'dpkg -i mysql-cluster-community-management-server_7.6.6-1ubuntu18.04_amd64.deb',
     'mkdir -p /var/lib/mysql-cluster',
     'touch /var/lib/mysql-cluster/config.ini',
     'echo "[ndbd default]" >> /var/lib/mysql-cluster/config.ini',
     'echo "NoOfReplicas=3" >> /var/lib/mysql-cluster/config.ini',
     'echo "[ndb_mgmd]" >> /var/lib/mysql-cluster/config.ini',
     f'echo "hostname=ip-{master_ip_parts[0]}-{master_ip_parts[1]}-{master_ip_parts[2]}-{master_ip_parts[3]}.ec2.internal" >> /var/lib/mysql-cluster/config.ini',
     'echo "NodeId=1" >> /var/lib/mysql-cluster/config.ini',
     'echo "datadir=/var/lib/mysql-cluster"  /var/lib/mysql-cluster/config.ini',
     'echo "[ndbd]" >> /var/lib/mysql-cluster/config.ini',
     f'echo "hostname=ip-{slave_1_parts[0]}-{slave_1_parts[1]}-{slave_1_parts[2]}-{slave_1_parts[3]}.ec2.internal" >> /var/lib/mysql-cluster/config.ini',
     'echo "NodeId=2" >> /var/lib/mysql-cluster/config.ini',
     'echo "datadir=/usr/local/mysql/data" >> /var/lib/mysql-cluster/config.ini',
     'echo "[ndbd]" >> /var/lib/mysql-cluster/config.ini',
     f'echo "hostname=ip-{slave_2_parts[0]}-{slave_2_parts[1]}-{slave_2_parts[2]}-{slave_2_parts[3]}.ec2.internal" >> /var/lib/mysql-cluster/config.ini',
     'echo "NodeId=3" >> /var/lib/mysql-cluster/config.ini',
     'echo "datadir=/usr/local/mysql/data" >> /var/lib/mysql-cluster/config.ini',
     'echo "[ndbd]" >> /var/lib/mysql-cluster/config.ini',
     f'echo "hostname=ip-{slave_3_parts[0]}-{slave_3_parts[1]}-{slave_3_parts[2]}-{slave_3_parts[3]}.ec2.internal" >> /var/lib/mysql-cluster/config.ini',
     'echo "NodeId=4" >> /var/lib/mysql-cluster/config.ini',
     'echo "datadir=/usr/local/mysql/data" >> /var/lib/mysql-cluster/config.ini',
     'echo "[mysqld]" >> /var/lib/mysql-cluster/config.ini',
     f'echo "hostname=ip-{master_ip_parts[0]}-{master_ip_parts[1]}-{master_ip_parts[2]}-{master_ip_parts[3]}.ec2.internal" >> /var/lib/mysql-cluster/config.ini',
     'source /var/lib/mysql-cluster/config.ini',
     'mkdir -p /etc/systemd/system/',
     'touch /etc/systemd/system/ndb_mgmd.service',
     'echo "[Unit]" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "Description=NDB Cluster Management Server" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "After=network.target auditd.service" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "[Service]" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "Type=forking" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "ExecStart=/usr/sbin/ndb_mgmd -f /var/lib/mysql-cluster/config.ini" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "ExecReload=/bin/kill -HUP $MAINPID" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "KillMode=process" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "Restart=on-failure" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "[Install]" >> /etc/systemd/system/ndb_mgmd.service',
     'echo "WantedBy=multi-user.target" >> /etc/systemd/system/ndb_mgmd.service',
     'source /etc/systemd/system/ndb_mgmd.service',
     'systemctl daemon-reload',
     'systemctl enable ndb_mgmd',
     'systemctl start ndb_mgmd',
     'touch status.ini',
     'systemctl status ndb_mgmd >> status.ini',
  ]

  for command in commands:
     result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

  # Return the command output as the response
  return result.stdout, 200

  # 0.0.0.0 allows incoming connections from any IP address
if __name__ == '__main__':
  app.run(host='0.0.0.0', port=80)
" | sudo tee main.py > /dev/null
nohup sudo python3 main.py > /dev/null 2>&1 &