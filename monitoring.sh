arch=$(uname -a)
phCPU=$(lscpu | grep "Socket(s)" | cut -d " " -f 24)
vrCPU=$(lscpu | grep "CPU(s)" | head -1 | cut -d " " -f 27)
pCPU=$(top -bn1 | grep "^%Cpu" | awk '{printf("%.1f%%"), 100 - $8}')
tRAM=$(free -m | awk 'NR==2' | awk '{print $2}')
uRAM=$(free -m | awk 'NR==2' | awk '{print $3}')
pRAM=$(free --mega | awk 'NR==2' | awk '{printf "%.0f", $3/$2*100}')
tDisk=$(df -BM --total | grep "total" | awk '{print $2}')
uDisk=$(df -BM --total | grep "total" | awk '{print $3}')
pDisk=$(df -BM --total | grep "total" | awk '{print $5}')
lBoot=$(who -b | grep "system" | awk '{print $3 " " $4}')
LVMt=$(lsblk | grep "lvm" | wc -l)
LVM=$(if [ $LVMt -eq 0 ]; then echo no; else echo yes; fi)
conn=$(netstat | grep -E "tcp|udp" | wc -l)
users=$(users | wc -w)
IPaddr=$(hostname -I)
MACaddr=$(ip link show | grep "link/ether" | awk '{print $2}')
SudoCmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

echo "#Architecture and version: $arch
#Physical CPUs: $phCPU
#Virtual CPUs: $vrCPU
#CPU load: $pCPU
#RAM usage: ${uRAM}MB/${tRAM}MB (${pRAM}%)
#Disk usage: $uDisk/$tDisk ($pDisk)
#Last reboot: $lBoot
#LVM active: $LVM
#Active Connections: $conn
#Users: $users
#Network: IP $IPaddr ($MACaddr)
#Sudo commands: $SudoCmds"