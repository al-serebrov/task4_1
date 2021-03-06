#!/bin/bash
DIR=$(dirname $0)
# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee -i "$DIR"/task4_1.out)

echo "--- Hardware ---"

# CPU: Intel xeon 2675
cpu=$(grep -i "model name" /proc/cpuinfo | uniq | cut -f3- -d" ")
echo "CPU: $cpu"

# RAM: xxxx
ram=$(grep MemTotal /proc/meminfo | awk '{print $2}')
echo "RAM: $ram KB"

# Motherboard: XXX XX / ??? / Unknown
mb_manuf=$(sudo dmidecode -s "baseboard-manufacturer")
mb_pname=$(sudo dmidecode -s "baseboard-product-name")
mb_sn=$(sudo dmidecode -s "system-serial-number")
echo "Motherboard: ${mb_manuf:-Unknown} / ${mb_pname:-Unknown}"

# System Serial Number: XXXXXX
echo "System Serial Number: ${mb_sn:-Unknown}"

echo "--- System ---"
# OS Distribution: xxxxx (например Ubuntu 16.04.4 LTS)
desrib_descr=$(grep -i "distrib_description" /etc/lsb-release -A0 | cut -f2 -d= | tr -d '""')
echo "OS Distribution: $desrib_descr"

# Kernel version: xxxx (например 4.4.0-116-generic)
echo "Kernel version: $(uname -r)"

# Installation date: xxxx
inst_date=$(stat -c "%y" /var/log/installer/ | cut -d" " -f1)
echo "Installation date: $inst_date"

# Hostname: yyyyy
echo "Hostname: $(uname -n)"

# Uptime: XX days
uptime=$(uptime -p | cut -d" " -f2-)
echo "Uptime: $uptime"

# Processes running: 56684
echo "Processes running: $(ps -aux | wc -l)"

# User logged in: 665
echo "User logged in: $(who | wc -l)"

echo "--- Network ---"
# <Iface #1 name>: IP/mask
# <Iface #2  name>: IP/mask
# …
# <Iface #N  name>: IP/mask

while IFS= read -r line; do
  addr="-"
    if [ ! -z $(cut -d" " -f3 <<< $line) ]; then
      addr=$(cut -d" " -f3-4 <<< $line)
    fi
    echo "$(cut -d" " -f1 <<< $line): $addr"
done < <( ip -4 -br addr show )

