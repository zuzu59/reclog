#!/usr/bin/env bash
#Petit script pour démarrer l'enregistrement des logs en version complexe

BASH_XTRACEFD="5" && PS4='$LINENO: ' && set -e -v -x

echo -e "
reclog2remote2file.sh  zf200831.1214"

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nUsage:
reclog2remote2file.sh user@host_remote port_reclog port_remote port_local filename
"
    exit
fi

host_remote=$1
port_reclog=$2
port_remote=$3
port_local=$4
filename=$5

reclog_stop() {
#for i in $(sudo netstat -natp |grep LIST |sort |grep -e 55514 -e 55614 | awk '{print $7}' | awk -F "/" '{print $1}'); do kill -9 $i ; done
  echo -e " oups on s'arrête..."
  zkill="for i in \$(sudo netstat -natp |grep LIST |sort |grep -e 55514 -e 55614 | awk '{print \$7}' | awk -F '/' '{print \$1}')\; do kill -9 \$i \; done"
  ssh $host_remote $zkill
  exit
}

reclog_stop
exit

ssh -t ubuntu@www.zuzu-test.ml "sudo /bin/bash -c \"for i in $(netstat -natp |grep LIST |sort |grep -e 55514 -e 55614 | awk '{print $7}' | awk -F '/' '{print $1}')\; do kill -9 $i\; done\" "


echo 'for i in $(sudo netstat -natp |grep LIST |sort |grep -e 55514 -e 55614 | awk \\'{print $7}\\' | awk -F \\'/\\' \\'{print $1}\\')' > zkill.sh

echo 'for i in sudo netstat -natp |grep LIST |sort |grep -e 55514 -e 55614 | awk \\'{print $7}\\' '

echo 'for i in $(sudo netstat -natp |grep LIST |sort |grep -e 55514 -e 55614) '

echo '(toto)'
echo 'do'
echo 'kill -9 $i' 
echo 'done'

 > zkill.sh


ssh ubuntu@www.zuzu-test.ml "sudo netstat -natp |grep LIST |sort |grep -e 55514 -e 55614 | awk '{print $7}' | awk -F '/' '{print $1}'""

ssh ubuntu@www.zuzu-test.ml "sudo /bin/bash -c \"netstat -natp |grep LIST |sort\""
ssh ubuntu@www.zuzu-test.ml "sudo /bin/bash -c \"netstat -natp |grep LIST |sort |grep -e 55514 -e 55614\""
ssh ubuntu@www.zuzu-test.ml "sudo /bin/bash -c \"netstat -natp |grep LIST |sort |grep -e 55514 -e 55614 | awk '{print \$7}'\""
ssh ubuntu@www.zuzu-test.ml "sudo /bin/bash -c \"netstat -natp |grep LIST |sort |grep -e 55514 -e 55614 | awk '{print \$7}' | awk -F '/' '{print \$1}'\""

' '|grep' -e 55514 -e 55614 '|' awk ''\''{print' '$7}'\''' '|' awk -F ''\''/'\''' ''\''{print' '$1}'\'')\;' do kill -9 '$i' '\;' done


trap reclog_stop INT

echo -e "\n---------- création du tunnel ssh reverse $port_local -> $port_remote..."
ssh -T -N -R $port_remote:localhost:$port_local $host_remote &
sleep 2


echo -e "\n---------- export du tunnel ssh reverse $port_remote -> $port_reclog..."
ssh $host_remote ssh -g -N -L $port_reclog:localhost:$port_remote localhost &
sleep 2

echo -e "\n---------- start reclog on port:$port_reclog -> file:$filename... (CTRL+C for stop)"
socat -u TCP4-LISTEN:$port_local,reuseaddr,fork OPEN:./$filename,creat,append


