# Parameters
USER=`whoami`
HOSTNAME=`uname -n`
IP=`hostname -i`
ROOT=`df -Ph | grep ROOT | awk '{print $4}'`
OSVERSION=`echo $(cat /etc/os-release) | grep "PRETTY_NAME" | awk -F'"' '{print $2 $3 $4}'`
MEMORY=`free -m | grep "Mem" | awk '{print $2,"-",$3,"-",$4}'`
SWAP=`free -m | grep "Swap" | awk '{print $2,"-",$3,"-",$4}'`
PSA=`ps -Afl | wc -l`
LOGGEDON=`ps -eaho user | sort -u | wc -l`

# time of day
#HOUR=$(date +"%H")
#if [ $HOUR -lt 12  -a $HOUR -ge 0 ]
#then    TIME="morning"
#elif [ $HOUR -lt 17 -a $HOUR -ge 12 ]
#then    TIME="afternoon"
#else
#    TIME="evening"
#fi

#System uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))

#System load
LOAD1=`cat /proc/loadavg | awk {'print $1'}`
LOAD5=`cat /proc/loadavg | awk {'print $2'}`
LOAD15=`cat /proc/loadavg | awk {'print $3'}`

COLOR_COLUMN="\e[1m-"
COLOR_VALUE="\e[0;92m"
RESET_COLORS="\e[0m"
if [ ! -f $HOME/.hushlogin ] 
then  echo "$(cat /etc/motd)";
echo -e "
===========================================================================
 $COLOR_COLUMN- Hostname$RESET_COLORS............: $COLOR_VALUE $HOSTNAME $RESET_COLORS
 $COLOR_COLUMN- IP Address$RESET_COLORS..........: $COLOR_VALUE $IP $RESET_COLORS
 $COLOR_COLUMN- Release$RESET_COLORS.............: $COLOR_VALUE $OSVERSION $RESET_COLORS
 $COLOR_COLUMN- Users$RESET_COLORS...............: $COLOR_VALUE Currently $LOGGEDON user(s) active $RESET_COLORS
=========================================================================== $RESET_COLORS
 $COLOR_COLUMN- Current user$RESET_COLORS........: $COLOR_VALUE $USER $RESET_COLORS
 $COLOR_COLUMN- CPU usage$RESET_COLORS...........: $COLOR_VALUE $LOAD1 - $LOAD5 - $LOAD15 (1-5-15 min) $RESET_COLORS
 $COLOR_COLUMN- Memory$RESET_COLORS..............: $COLOR_VALUE $MEMORY (total-free-used) $RESET_COLORS
 $COLOR_COLUMN- Swap$RESET_COLORS................: $COLOR_VALUE $SWAP (total-used-free) MB $RESET_COLORS
 $COLOR_COLUMN- Processes$RESET_COLORS...........: $COLOR_VALUE $PSA running $RESET_COLORS
 $COLOR_COLUMN- System uptime$RESET_COLORS.......: $COLOR_VALUE $upDays days $upHours hours $upMins minutes $upSecs seconds $RESET_COLORS
 $COLOR_COLUMN- Disk space ROOT$RESET_COLORS.....: $COLOR_VALUE $ROOT remaining $RESET_COLORS
===========================================================================
"
fi