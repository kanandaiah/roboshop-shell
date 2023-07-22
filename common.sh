app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head() {
  func_print_head<< $1>>>>>>>>>>\e[0m"
}

func_schema_setup() {
  if [ "$schema_setup" == "mongo" ]; then
    func_print_head "copy mongo repo files"
    cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
    func_print_head "install mongodb"
    yum install mongodb-org-shell -y
    func_print_head "mongo ip address"
    mongo --host mongodb-dev.kanand.online </app/schema/${component}.js
  fi
  if [ "$schema_setup" == "mysql" ]; then
    func_print_head "install mysql"
    yum install mysql -y
    func_print_head "load msql schema"
    mysql -h mysql-dev.kanand.online -uroot -p${mysql_root_password} < /app/schema/${component}.sql
  fi
}
func_app_prereq() {
   func_print_head "add user"
   useradd ${app_user}
   func_print_head "create app directory"
   rm -rf /app
   mkdir /app
   func_print_head "download shipping repo"
   curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
   cd /app
   func_print_head "unzinping files"
   unzip /tmp/${component}.zip

}
func_systemd_setup() {
   func_print_head "copy systemd service"
   cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
   func_print_head "daemon reload"
   systemctl daemon-reload
   func_print_head "enable and start"
   systemctl enable ${component}
   systemctl restart ${component}
  }
func_nodejs()
{
  func_print_head "rpm file"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  func_print_head "install node js"
  yum install nodejs -y

  func_app_prereq

  func_print_head "install npm"
  npm install
  func_schema_setup
  func_systemd_setup

}

func_java() {
  func_print_head "install maven"
  yum install maven -y
  func_app_prereq
  func_print_head  "clean package"
  mvn clean package
  func_print_head "name changing"
  mv target/${component}-1.0.jar ${component}.jar
  func_schema_setup
  func_systemd_setup

}