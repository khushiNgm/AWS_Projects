#!/bin/bash
sudo -i
yum update -y
yum install -y httpd wget unzip
systemctl start httpd
systemctl enable httpd
cd /tmp

wget https://templatemo.com/download/templatemo_602_graph_page -O graph.zip

unzip -o graph.zip -d graph_template

FOLDER=$(find graph_template -type f -name "index.html" -exec dirname {} \; | head -n 1)
cp -r "$FOLDER"/* /var/www/html/
systemctl restart httpd

