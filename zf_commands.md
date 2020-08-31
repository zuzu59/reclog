# Mes petits trucs à moi pour bien travailler ;-)
#zf200831.1214

<!-- TOC titleSize:2 tabSpaces:2 depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 skip:2 title:1 charForUnorderedList:* -->
## Table of Contents
* [Version simple](#version-simple)
  * [Test de la connexion](#test-de-la-connexion)
* [Version complexe](#version-complexe)
  * [Test de la connexion](#test-de-la-connexion)
<!-- /TOC -->

# Version simple
dans une console en local
```
socat -u TCP4-LISTEN:55514,reuseaddr,fork OPEN:./file.log,creat,append
```

## Test de la connexion
dans une autre console en local
```
telnet localhost 55514
```
Encore dans une autre console en local
```
tail -f file.log
```


# Version complexe
dans une console en local
```
ssh ubuntu@www.zuzu-test.ml
```

```
export user=ubuntu
export host_remote=www.zuzu-test.ml
export port_remote=55614
export port_local=55514
ssh -N -R $port_remote:localhost:$port_local $user@$host_remote &
```
dans une autre console en local
```
export user=ubuntu
export host_remote=www.zuzu-test.ml
export port_reclog=55514
export port_remote=55614
ssh -t $user@$host_remote ssh -g -N -L $port_reclog:localhost:$port_remote localhost
```
Enfin dans une autre console en local
```
export port_local=55514
export filename=file.log
socat -u TCP4-LISTEN:$port_local,reuseaddr,fork OPEN:./$filename,creat,append
```

## Test de la connexion
Encore dans une autre console en local
```
export host_remote=www.zuzu-test.ml
export port_reclog=55514
telnet $host_remote $port_reclog
```
Encore dans une autre console en local
```
export filename=file.log
tail -f $filename
```


pour tuer tous les process qui ont 55514 dans leur nom:
```
for i in $(ps ax |grep 55514 | awk '{print $1}'); do kill -9 $i; done
```








