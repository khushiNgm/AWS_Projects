#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
echo "Welcome to EC2-Server-1" | sudo tee /var/www/html/index.html