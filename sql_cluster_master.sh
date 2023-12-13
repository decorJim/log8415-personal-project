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

@app.route('/health')
def health_check():
  # If everything is fine, return a 200 OK response when ping http://your-instance-ip:80/health
  command = f'echo "12345678" > test.txt'
  result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
  return 'OK', 200

@app.route('/run_command', methods=['POST'])
def run_command():
  # Get IP addresses from the request
  ip1 = request.form.get('ip1')
  ip2 = request.form.get('ip2')
  ip3 = request.form.get('ip3')
  ip4 = request.form.get('ip4')
  ip5 = request.form.get('ip5')

  os.chdir('/')

  commands=[
     f'echo "IP1: {ip1}, IP2: {ip2}, IP3: {ip3}, IP4 {ip4}, IP5 {ip5}" > clusterip.txt',
     'apt-get install libaio1 -y',
     'apt-get install unzip -y',
     'apt-get install libmecab2 -y',
     'apt-get install sysbench -y',
     'apt-get install libncurses5 -y',
     'apt-get install libtinfo5 -y',
     'touch confirms.ini',
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