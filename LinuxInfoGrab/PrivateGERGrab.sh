#!/bin/bash
# Init
FILE="/tmp/out.$$"
GREP="/bin/grep"

# Output warning if not root
if [ "$(id -u)" != "0" ]; then
   echo ""
   echo "You are not root! This script may not display all info! If possible, run as root!" 1>&2
fi

echo ""
echo "+----------------------------------------------+"
echo "| PrivateGER Linux Information Grabber v1.0.0a |"
echo "+----------------------------------------------+"
echo ""
loggedinAsText="You are logged in as "
idText=" with ID "
userName="$(who)"
userID="$(id)"

echo $loggedinAsText$userName$idText$userID
echo ""
echo "All currently open ports on the machine:"
netstat -tuwanp4 | awk '{print $4}' | grep ':' | cut -d ":" -f 2 | sort | uniq
echo ""
echo "-----------------------------------------------"
echo ""
echo "All existing users on the machine: "
awk -F":" '{ print "" $1 "\t\tuid:" $3 }' /etc/passwd 
echo ""
echo "-----------------------------------------------"
echo ""
echo "Useful packages installation status: "
[ -f /usr/bin/gcc ] && echo "GCC is installed!" || echo "GCC is NOT installed!"
[ -f /usr/bin/g++ ] && echo "G++ is installed!" || echo "G++ is NOT installed!"
[ -f /usr/bin/xterm ] && echo "xterm is installed!" || echo "xterm is NOT installed!"
echo ""
echo "-----------------------------------------------"
echo ""
echo "List of connected/active users/terminals"
who
echo ""
echo "-----------------------------------------------"
echo ""
echo "Installation status of interesting services: "
[ -f /usr/sbin/apache2 ] && echo "apache2 is installed!" || echo "apache2 is NOT installed!"
[ -f /usr/bin/nginx ] && echo "nginx is installed!" || echo "nginx is NOT installed!"
[ -f /usr/bin/pihole ] && echo "PiHole is installed!" || echo "PiHole is NOT installed!"

echo ""
echo "-----------------------------------------------"
echo ""
echo "Files owned by root, but with 777 permissions:"
find /home/ -user root -perm 777 \( -type f -o -type d \) -ls

if [ "$(id -u)" = "0" ];
  then
    find /root/ -user root -perm 777 \( -type f -o -type d \) -ls
  else
    echo "No root rights, so script cannot search /root folder!"
fi

echo ""
echo "-----------------------------------------------"
echo ""
echo "List of PHP files in /var/www/html:"
find /var/www/html -type f -name "*.php"
echo ""
echo "-----------------------------------------------"
echo ""
echo "User Passwords: "
if [ "$(id -u)" = "0" ]; 
   then
     cat /etc/shadow
   else
     echo ""
     echo "Script is NOT root, so it cannot show the user passwords!"
fi
echo ""
echo "-----------------------------------------------"
echo ""
echo "All enviroment variables:"
env
echo ""
echo "-----------------------------------------------"
echo ""
echo "List of services running as root:"
ps -ef | grep root
echo ""
echo "-----------------------------------------------"
echo ""
echo "List of cronjobs:"
crontab -l
echo ""
echo "-----------------------------------------------"
echo ""
echo "ipconfig Output:"
/sbin/ifconfig -a
echo ""
echo "-----------------------------------------------"
echo ""
echo "DNS Server:"
dnsdomainname
echo ""
echo "-----------------------------------------------"
echo ""
echo ""
