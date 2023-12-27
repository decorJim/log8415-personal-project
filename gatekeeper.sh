#!/bin/bash

# NEED TO CHANGE EVERY SESSION
ACCESS_KEY_ID=
SECRET_ACCESS_KEY_ID=
REGION="us-east-1"

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install python3-pip -y
sudo pip3 install flask
sudo pip3 install sshtunnel
sudo pip3 install botocore
sudo pip3 install load_dotenv
sudo pip3 install requests

sudo git clone https://github.com/decorJim/gatekeeper.git
cd gatekeeper

sudo chmod 400 tmp1.pem
sudo touch .env
echo "ACCESS_KEY_ID=$ACCESS_KEY_ID" | sudo tee -a .env
echo "SECRET_ACCESS_KEY_ID=$SECRET_ACCESS_KEY_ID" | sudo tee -a .env
echo "REGION=$REGION" | sudo tee -a .env

sudo python3 app.py