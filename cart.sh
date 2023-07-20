echo -e "\e[32m <<<<<<<< rpm file>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m <<<<<<<< install node js >>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[32m <<<<<<<< add roboshop>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[32m <<<<<<<< create app directory>>>>>>>>>>\e[0m"
mkdir /app
echo -e "\e[32m <<<<<<<donload ip file >>>>>>>>>>\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
echo -e "\e[32m <<<<<<<< extract ip file >>>>>>>>>>\e[0m"
unzip /tmp/cart.zip
echo -e "\e[32m <<<<<<<< install npm  >>>>>>>>>>\e[0m"
npm install
echo -e "\e[32m <<<<<<<< copy cart service >>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[32m <<<<<<<< reaload daemon service >>>>>>>>>>\e[0m"
systemctl daemon-reload
echo -e "\e[32m <<<<<<<< enable and start service >>>>>>>>>>\e[0m"
systemctl enable cart
systemctl start cart
