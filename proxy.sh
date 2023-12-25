#!/bin/bash

# ******************************** COPY AND PASTE public ip from terminal *************************
# PUBLIC master
IP_ADDRESS_1=54.208.185.196

# PUBLIC slave 1
IP_ADDRESS_2=52.87.229.14
# PUBLIC slave 2
IP_ADDRESS_3=44.203.181.50
# PUBLIC slave 3
IP_ADDRESS_4=54.166.118.162

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install python3-pip -y
sudo pip3 install flask
sudo pip3 install pymysql
sudo pip3 install sshtunnel
sudo pip3 install pythonping

sudo git clone https://github.com/decorJim/proxy-app

cd proxy-app

sudo python3 app.y $IP_ADDRESS_1 $IP_ADDRESS_2 $IP_ADDRESS_3 $IP_ADDRESS_4
