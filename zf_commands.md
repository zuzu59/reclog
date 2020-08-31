# Mes petits trucs à moi pour bien travailler ;-)
#zf200831.1449

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

