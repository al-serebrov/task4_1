echo "--- Hardware ---"

# CPU: Intel xeon 2675
cpu=$(grep -i "model name" /proc/cpuinfo | uniq | cut -f3- -d" ")
echo "CPU: $cpu"

# RAM: xxxx 
ram=$(grep -i "memtotal" /proc/meminfo | uniq | cut -f9- -d" ")
echo "RAM: $ram"

# Motherboard: XXX XX / ??? / Unknown
mb_manuf=$(sudo dmidecode -s "baseboard-manufacturer")
mb_pname=$(sudo dmidecode -s "baseboard-product-name")
mb_version=$(sudo dmidecode -s "baseboard-version")
mb_sn=$(sudo dmidecode -s "baseboard-serial-number")
mb_asset_tag=$(sudo dmidecode -s "baseboard-asset-tag")
echo "Motherboard: $mb_manuf / $mb_pname / $mb_version / $mb_sn / $mb_asset_tag"

# System Serial Number: XXXXXX
sys_serial_num=$(sudo dmidecode -s system-serial-number)
echo "System Serial Number: $sys_serial_num"

echo "--- System ---"
# OS Distribution: xxxxx (например Ubuntu 16.04.4 LTS)
desrib_descr=$(grep -i "distrib_description" /etc/lsb-release -A0 | cut -f2 -d= | tr -d '""')
echo "OS Distribution: $desrib_descr"

# Kernel version: xxxx (например 4.4.0-116-generic)
echo "Kernel version: $(uname -r)"

# Installation date: xxxx
inst_date=$(ls -alp /etc/ssh/ssh_host_dsa_key.pub | cut -d" " -f6-9)
echo "Installation date: $inst_date"

# Hostname: yyyyy
echo "Hostname: $(uname -n)"

# Uptime: XX days
echo "Uptime: $(uptime -p)"

# Processes running: 56684
echo "Processes running: $(ps -aux | wc -l)"

# User logged in: 665
echo "User logged in: $(who | wc -l)"

echo "--- Network ---"
# <Iface #1 name>:  IP/mask
# <Iface #2  name>:  IP/mask
# …
# <Iface #N  name>:  IP/mask
