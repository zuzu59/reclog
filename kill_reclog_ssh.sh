#!/usr/bin/env bash
#Petit script pour arrêter les tunnels ssh sur le remote host

#BASH_XTRACEFD="5" && PS4='$LINENO: ' && set -e -v -x

echo -e "
relog_kill_ssh.sh  zf200831.1442"

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nUsage:
relog_kill_ssh.sh port_reclog port_remote
"
    exit
fi

port_reclog=$1
port_remote=$2

for i in $(sudo netstat -natp |grep LIST |sort |grep -e $1 -e $2 | awk '{print $7}' | awk -F "/" '{print $1}')
do
  kill -9 $i
done

rm $0
