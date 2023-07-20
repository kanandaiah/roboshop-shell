echo -e "\e[32m <<<<<<<< rpm file>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m <<<<<<<< install node js>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[32m <<<<<<<< add roboshop>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[32m <<<<<<<< create app directory>>>>>>>>>>\e[0m"
mkdir /app
echo -e "\e[32m <<<<<<<< download ip file>>>>>>>>>>\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
echo -e "\e[32m <<<<<<<< extract zip file>>>>>>>>>>\e[0m"
unzip /tmp/user.zip
echo -e "\e[32m <<<<<<<< install npm>>>>>>>>>>\e[0m"
npm install
echo -e "\e[32m <<<<<<<< copy user service file>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service
echo -e "\e[32m <<<<<<<< reload daemon>>>>>>>>>>\e[0m"
systemctl daemon-reload
echo -e "\e[32m <<<<<<<< enable and start user>>>>>>>>>>\e[0m"
systemctl enable user
systemctl restart user
echo -e "\e[32m <<<<<<<< copy mongo repo files>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[32m <<<<<<<< install mongodb>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[32m <<<<<<<< mongo ip address>>>>>>>>>>\e[0m"
mongo --host mongodb-dev.kanand.online </app/schema/user.js