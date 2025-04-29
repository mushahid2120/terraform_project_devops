#!/bin/bash
sudo yum install git -y
sudo git clone https://github.com/mushahid2120/terraform_project_devops.git
sudo sh -c 'echo "export ALB_ENDPOINT=${alb_endpoint}" >> /etc/profile'
sudo sh -c 'echo "export FRONTEND_LB_ENDPOINT=${frontend_lb_endpoint}">> /etc/profile'
source /etc/profile
sudo yum install npm* -y
cd terraform_project_devops/app/frontend/vite-react-project
sudo npm update
sudo npm install
npm run dev &
echo $ALB_ENDPOINT