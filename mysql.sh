script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]; then
  echo input mysql root password missing
  exit
fi

func_print_head<< disable msl versions>>>>>>>>>>\e[0m"
yum module disable mysql -y
func_print_head<< copy mysql files>>>>>>>>>>\e[0m"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo
func_print_head<< install mysl community>>>>>>>>>>\e[0m"
yum install mysql-community-server -y
func_print_head<< enable and start mysql>>>>>>>>>>\e[0m"
systemctl enable mysqld
systemctl restart mysqld
func_print_head<< set root passwd>>>>>>>>>>\e[0m"
mysql_secure_installation --set-root-pass $mysql_root_password
