echo -e "\e[32m <<<<<<<< configure nodejs >>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m <<<<<<<< install nodejs >>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[32m <<<<<<<< add roboshop >>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[32m <<<<<<<< create directory >>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[32m <<<<<<<< catalogue zip file >>>>>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo -e "\e[32m <<<<<<<< inside the dirctory  >>>>>>>>>>\e[0m"
cd /app
echo -e "\e[32m <<<<<<<< extract ip file >>>>>>>>>>\e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[32m <<<<<<<< install npm >>>>>>>>>>\e[0m"
npm install
echo -e "\e[32m <<<<<<<< copy the catalogue service file >>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[32m <<<<<<<< daemon reload >>>>>>>>>>\e[0m"
systemctl daemon-reload
echo -e "\e[32m <<<<<<<<enable and start service >>>>>>>>>>\e[0m"
systemctl enable catalogue
systemctl restart catalogue
echo -e "\e[32m <<<<<<<< copy repo files >>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[32m <<<<<<<< install mongodb >>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[32m <<<<<<<< load mongodb schema >>>>>>>>>>\e[0m"
mongo --host mongodb-dev.kanand.online </app/schema/catalogue.js