echo -e "\e[32m <<<<<<<< disable msl versions>>>>>>>>>>\e[0m"
yum module disable mysql -y
echo -e "\e[32m <<<<<<<< copy mysql files>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[32m <<<<<<<< install mysl community>>>>>>>>>>\e[0m"
yum install mysql-community-server -y
echo -e "\e[32m <<<<<<<< enable and start mysql>>>>>>>>>>\e[0m"
systemctl enable mysqld
systemctl start mysqld
echo -e "\e[32m <<<<<<<< set root passwd>>>>>>>>>>\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
echo -e "\e[32m <<<<<<<< u root passwd>>>>>>>>>>\e[0m"
mysql -uroot -pRoboShop@1