#!/bin/bash
sudo -i
yum update -y
yum install -y httpd wget unzip
systemctl start httpd
systemctl enable httpd
cd /tmp

wget https://templatemo.com/download/templatemo_577_liberty_market -O liberty.zip

unzip -o liberty.zip -d liberty_template
FOLDER=$(find liberty_template -type f -name "index.html" -exec dirname {} \; | head -n 1)
cp -r "$FOLDER"/* /var/www/html/
systemctl restart httpd