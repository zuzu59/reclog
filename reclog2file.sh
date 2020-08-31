#!/usr/bin/env bash
#Petit script pour démarrer l'enregistrement des logs en version simple

echo -e "
reclog2file.sh  zf200831.1056"

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nUsage:
reclog2file.sh port_reclog filename
"
    exit
fi


port_reclog=$1
filename=$2

echo -e "\n---------- start reclog on port:$port_reclog -> file:$filename... (CTRL+C for stop)"
socat -u TCP4-LISTEN:$port_reclog,reuseaddr,fork OPEN:./$filename,creat,append


