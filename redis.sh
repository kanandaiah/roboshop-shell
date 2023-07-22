script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
func_print_head<< redis repo >>>>>>>>>>\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
func_print_head<< redis version >>>>>>>>>>\e[0m"
yum module enable redis:remi-6.2 -y
func_print_head<< install redis>>>>>>>>>>\e[0m"
yum install redis -y
func_print_head<< changing address >>>>>>>>>>\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf
func_print_head<< enable and start service>>>>>>>>>>\e[0m"
systemctl enable redis
systemctl restart redis