# Mes petits trucs à moi pour bien travailler ;-)
#zf200901.1105

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
./reclog2file.sh 55514 file.log
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