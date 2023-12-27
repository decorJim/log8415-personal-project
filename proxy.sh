#!/bin/bash

# NEED TO CHANGE EVERY SESSION
ACCESS_KEY_ID="AKIATWQRHF25U63XMZEB"
SECRET_ACCESS_KEY_ID="WCwQi7ar3FlPA9vvzfsuU9bC9nXAbbVui/qulKBJ"
REGION="us-east-1"

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install python3-pip -y
sudo pip3 install flask
sudo pip3 install pymysql
sudo pip3 install sshtunnel
sudo pip3 install pythonping
sudo pip3 install botocore
sudo pip3 install load_dotenv

sudo git clone https://github.com/decorJim/proxy-app

cd proxy-app
# change the key everytime the code is executed
sudo chmod 400 tmp1.pem
sudo touch .env
echo "ACCESS_KEY_ID=$ACCESS_KEY_ID" | sudo tee -a .env
echo "SECRET_ACCESS_KEY_ID=$SECRET_ACCESS_KEY_ID" | sudo tee -a .env
echo "REGION=$REGION" | sudo tee -a .env

sudo python3 app.py
