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
rabbitmqctl add_user roboshop roboshop123
echo -e "\e[32m <<<<<<<<set permission>>>>>>>>>>\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
