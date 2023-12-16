#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
      
sudo apt-get install python3-pip -y
sudo pip3 install flask

sudo mkdir app
cd app

echo "from flask import Flask,request
import requests
import subprocess
import os

app = Flask(__name__)

ip1 = None

@app.route('/health')
def health_check():
  # If everything is fine, return a 200 OK response when ping http://your-instance-ip:80/health
  command = f'echo "12345678" > test.txt'
  result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
  return 'OK', 200

@app.route('/run_command', methods=['POST'])
def run_command():
  ip1 = request.form.get('ip1')

  os.chdir('/')

  master_ip_parts=ip1.split('.')

  commands=[
     'sudo apt-get update -y',
     'sudo apt-get install sysbench -y',
     'sudo apt-get install libclass-methodmaker-perl -y',
     'wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb',
     'sudo dpkg -i mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb',
     'sudo touch /etc/my.cnf',
     'echo "[mysql_cluster]" | sudo tee -a /etc/my.cnf',
     f'echo "ndb-connectstring=ip-{master_ip_parts[0]}-{master_ip_parts[1]}-{master_ip_parts[2]}-{master_ip_parts[3]}.ec2.internal" | sudo tee -a /etc/my.cnf',
     'mkdir -p /usr/local/mysql/data',
     'mkdir -p /etc/systemd/system/',
     'sudo touch /etc/systemd/system/ndbd.service',
     'echo "[Unit]" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "Description=MySQL NDB Data Node Daemon" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "After=network.target auditd.service" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "[Service]" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "Type=forking" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "ExecStart=/usr/sbin/ndbd" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "ExecReload=/bin/kill -HUP \$MAINPID" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "KillMode=process" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "Restart=on-failure" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "[Install]" | sudo tee -a /etc/systemd/system/ndbd.service',
     'echo "WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/ndbd.service',
     'sudo systemctl daemon-reload',
     'sudo systemctl enable ndbd',
     'sudo systemctl start ndbd',
     'sudo touch status.ini',
     'sudo systemctl status ndbd >> status.ini'
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