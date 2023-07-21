script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1
if [ -z "$rabbitmq_appuser_password" ]; then
  echo input roboshop appuser password missing
  exit
fi
echo -e "\e[32m <<<<<<<< install erlang>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[32m <<<<<<<< install rabbitmq server>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[32m <<<<<<<< install rabbitmq server>>>>>>>>>>\e[0m"
yum install rabbitmq-server -y
echo -e "\e[32m <<<<<<<< enable and restart rabbitmq>>>>>>>>>>\e[0m"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server
echo -e "\e[32m <<<<<<<< add user>>>>>>>>>>\e[0m"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
echo -e "\e[32m <<<<<<<<set permission>>>>>>>>>>\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
