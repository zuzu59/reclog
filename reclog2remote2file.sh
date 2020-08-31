#!/bin/bash
#Petit script pour démarrer l'enregistrement des logs en version complexe

echo -e "
reclog2remote2file.sh  zf200831.1005"

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
  echo -e " oups on s'arrête..."
  exit
}
trap reclog_stop INT

echo -e "\n---------- start reclog on port:$port_reclog -> file:$filename... (CTRL+C for stop)"
socat -u TCP4-LISTEN:$port_reclog,reuseaddr,fork OPEN:./$filename,creat,append

