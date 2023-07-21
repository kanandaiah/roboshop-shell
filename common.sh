app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head() {
  echo -e "\e[32m <<<<<<<< $1>>>>>>>>>>\e[0m"
}

schema_setup() {
  print_head "copy mongo repo files"
  cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

  print_head "install mongodb"
  yum install mongodb-org-shell -y
  print_head "mongo ip address"
  mongo --host mongodb-dev.kanand.online </app/schema/${component}.js
}
func_nodejs()
{
print_head "rpm file"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

print_head "install node js"
yum install nodejs -y

print_head "add roboshop"
useradd ${app_user}

print_head "create app directory"
rm -rf /app
mkdir /app

print_ head "donload ip file"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
cd /app

print_head "extract ip file"
unzip /tmp/${component}.zip

print_head "install npm"
npm install

print_head "copy cart service"
cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

print_head "reaload daemon service"
systemctl daemon-reload

print_head "enable and start service"
systemctl enable ${component}
systemctl restart ${component}
schema_setup
}