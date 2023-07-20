echo -e "\e[32m <<<<<<<< install maven>>>>>>>>>>\e[0m"
yum install maven -y
echo -e "\e[32m <<<<<<<< add user>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[32m <<<<<<<< create app directory>>>>>>>>>>\e[0m"
mkdir /app
echo -e "\e[32m <<<<<<<< download shipping repo>>>>>>>>>>\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
echo -e "\e[32m <<<<<<<< unzinping files >>>>>>>>>>\e[0m"
unzip /tmp/shipping.zip
echo -e "\e[32m <<<<<<<< clean package>>>>>>>>>>\e[0m"
mvn clean package
echo -e "\e[32m <<<<<<<< name changing>>>>>>>>>>\e[0m"
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[32m <<<<<<<< cop shipping service>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[32m <<<<<<<< daemon reload>>>>>>>>>>\e[0m"
systemctl daemon-reload
echo -e "\e[32m <<<<<<<< enable and start>>>>>>>>>>\e[0m"
systemctl enable shipping
systemctl start shipping
echo -e "\e[32m <<<<<<<< install mysql>>>>>>>>>>\e[0m"
yum install mysql -y
echo -e "\e[32m <<<<<<<< load msql schema>>>>>>>>>>\e[0m"
mysql -h mysql-dev.kanand.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
echo -e "\e[32m <<<<<<<< restart service>>>>>>>>>>\e[0m"
systemctl restart shipping