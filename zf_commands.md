# Mes petits trucs à moi pour bien travailler ;-)
#zf200916.1105

<!-- TOC titleSize:2 tabSpaces:2 depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 skip:2 title:1 charForUnorderedList:* -->
## Table of Contents
* [Version simple](#version-simple)
  * [Test de la connexion simple en local](#test-de-la-connexion-simple-en-local)
  * [Test de la connexion simple en remote](#test-de-la-connexion-simple-en-remote)
* [Version complexe](#version-complexe)
  * [Test de la connexion](#test-de-la-connexion)
<!-- /TOC -->

# Version simple
dans une console en local:
```
./reclog2file.sh 55514 file.log
```

ou dans une console en remote:
```
scp ./reclog2file.sh ubuntu@www.zuzu-test.ml:~/reclog2file.sh

ssh ubuntu@www.zuzu-test.ml rm file.log
ssh -t ubuntu@www.zuzu-test.ml ./reclog2file.sh 55514 file.log
```

Pour voir le résultat en remote, dans une autre console en local:
```
ssh ubuntu@www.zuzu-test.ml tail -f file.log
```

Enfin après pour récupérer le fichier de logs, dans une autre console:
Ne pas oublier de faire, AVANT, un CTRL+C pour le reclog !
```
scp ubuntu@www.zuzu-test.ml:~/file.log ./file.log
```


## Test de la connexion simple en local
dans une autre console en local (sur MAC CTRL+tréma, pour sortir de telnet)
```
telnet www.zuzu-test.ml 55514
```
Encore dans une autre console en local
```
ssh ubuntu@www.zuzu-test.ml tail -f file.log
```


## Test de la connexion simple en remote
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
rm file.log
./reclog2remote2file.sh ubuntu@www.zuzu-test.ml 55514 55614 55514 file.log
```

## Test de la connexion
Encore dans une autre console en local
```
telnet www.zuzu-test.ml 55514
```
Encore dans une autre console en local
```
tail -f file.log
```

python3
from datetime import datetime
print(str(datetime.now()))

print("toto")


from datetime import datetime, timezone, timedelta

utc_dt = datetime.now(timezone.utc)

print("Local time {}".format(utc_dt.astimezone().isoformat()))

print(datetime.now(timezone.cest))

offset = timezone(timedelta(hours=0))

print(datetime.now(timezone(timedelta(hours=2))))

print(datetime.now(timezone(timedelta(hours=2))))

print(timedelta(hours=2))