script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1
if [ -z "$rabbitmq_appuser_password" ]; then
  echo input roboshop appuser password missing
  exit
fi
func_print_head<< install erlang>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
func_print_head<< install rabbitmq server>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
func_print_head<< install rabbitmq server>>>>>>>>>>\e[0m"
yum install rabbitmq-server -y
func_print_head<< enable and restart rabbitmq>>>>>>>>>>\e[0m"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server
func_print_head<< add user>>>>>>>>>>\e[0m"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
func_print_head<<set permission>>>>>>>>>>\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
