#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
      
sudo apt-get install python3-pip -y
sudo pip3 install flask

sudo mkdir app
cd app

git clone https://github.com/decorJim/log8415-personal-project
mv /app/log8415-personal-project/slave_setup.sh /

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

  script = f'sudo bash /app/check.sh {ip1}'
  result = subprocess.run(script, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

  # Return the command output as the response
  return result.stdout, 200

# 0.0.0.0 allows incoming connections from any IP address
if __name__ == '__main__':
  app.run(host='0.0.0.0', port=80)
" | sudo tee main.py > /dev/null
nohup sudo python3 main.py > /dev/null 2>&1 &