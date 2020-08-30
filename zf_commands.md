# Mes petits trucs à moi pour bien travailler ;-)
#zf200830.1527

<!-- TOC titleSize:2 tabSpaces:2 depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 skip:2 title:1 charForUnorderedList:* -->
## Table of Contents
* [Version simple](#version-simple)
  * [Test de la connexion](#test-de-la-connexion)
* [Version complexe](#version-complexe)
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
ssh -R 55514:localhost:55514 ubuntu@www.zuzu-test.ml

ssh ubuntu@www.zuzu-test.ml socat -u TCP-LISTEN:55514,reuseaddr,fork TCP-LISTEN:55614,reuseaddr,bind=127.0.0.1

socat -u TCP-LISTEN:55514,reuseaddr,fork TCP-LISTEN:55614,reuseaddr,bind=127.0.0.1

 ```
dans une autre console en local
```
socat -u TCP4-LISTEN:55514,reuseaddr,fork OPEN:./file.log,creat,append

ssh -N -L 55514:localhost:55614 ubuntu@www.zuzu-test.ml
```
Encore dans une autre console en local
```
socat -u TCP4-LISTEN:55514,reuseaddr,fork OPEN:./file.log,creat,append

socat TCP4:localhost:55514 OPEN:./file.log,creat,append


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









