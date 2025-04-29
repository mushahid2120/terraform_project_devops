#!/bin/bash
sudo yum install git -y
sudo git clone https://github.com/mushahid2120/terraform_project_devops.git
sudo sh -c 'echo "export RDS_ENDPOINT=${rds_endpoint}" >> /etc/profile'
sudo sed -i 's/:3306//g' /etc/profile
source /etc/profile
sudo yum install npm* -y
cd terraform_project_devops/app/backend/
sudo npm update
sudo npm install
npm start &
echo $RDS_ENDPOINT

# sudo yum install httpd -y 
# sudo systemctl start httpd
# sh -c  "echo Autoscaling_group > /var/www/html/index.html"
