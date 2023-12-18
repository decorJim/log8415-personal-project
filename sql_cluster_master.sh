#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
      
sudo apt-get install python3-pip -y
sudo pip3 install flask

sudo mkdir app
cd app
git clone https://github.com/decorJim/log8415-personal-project
mv /app/log8415-personal-project/check.sh /
mv /app/log8415-personal-project/master_setup.sh /

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

  script = f'sudo bash master_setup.sh {ip1} {ip2} {ip3} {ip4}'
  result = subprocess.run(script, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

  # Return the command output as the response
  return result.stdout, 200

  # 0.0.0.0 allows incoming connections from any IP address
if __name__ == '__main__':
  app.run(host='0.0.0.0', port=80)
" | sudo tee main.py > /dev/null
nohup sudo python3 main.py > /dev/null 2>&1 &