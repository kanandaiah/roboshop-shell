script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1
func_print_head<< install python>>>>>>>>>>\e[0m"
yum install python36 gcc python3-devel -y
func_print_head<< add user>>>>>>>>>>\e[0m"
useradd ${app_user}
func_print_head<< create ap directory>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
func_print_head<< donload ip file>>>>>>>>>>\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
func_print_head<< extract ip file>>>>>>>>>>\e[0m"
unzip /tmp/payment.zip
func_print_head<< install python>>>>>>>>>>\e[0m"
pip3.6 install -r requirements.txt
func_print_head<< copy payment service>>>>>>>>>>\e[0m"
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service
cp ${script_path}/payment.service /etc/systemd/system/payment.service
func_print_head<< daemon reload>>>>>>>>>>\e[0m"
systemctl daemon-reload
func_print_head<< enable and restart payment>>>>>>>>>>\e[0m"
systemctl enable payment
systemctl restart payment