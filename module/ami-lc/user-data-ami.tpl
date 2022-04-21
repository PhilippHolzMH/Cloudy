#!/bin/bash
sudo yum install -y httpd mysql php postgressql|
sudo chkconfig httpd on
sudo systemctl enable httpd |
sudo systemctl start httpd |
sudo echo '<html><h1>Hello From Your Web Server!</h1><html>' > /var/www/html/index.html
