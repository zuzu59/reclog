# reclog
Système très simple d'enregistrement de logs via le réseau

zf200831.0918

# ATTENTION, en cours de rédaction !


<!-- TOC titleSize:2 tabSpaces:2 depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 skip:1 title:1 charForUnorderedList:* -->
## Table of Contents
* [ATTENTION, en cours de rédaction !](#attention-en-cours-de-rédaction-)
* [Buts](#buts)
* [Problématiques](#problématiques)
* [Moyens](#moyens)
* [Deux versions sont possibles](#deux-versions-sont-possibles)
  * [Version simple](#version-simple)
    * [Test de la connexion](#test-de-la-connexion)
  * [Version complexe avec un tremplin tunnel reverse ssh](#version-complexe-avec-un-tremplin-tunnel-reverse-ssh)
  * [Test de la connexion](#test-de-la-connexion)
<!-- /TOC -->


# Buts
*reclog* permet très simplement d'enregistrer des événements de *debug*, du style *print console*, d'un processus *isolé* à distance via un *socket*. Un peu le même principe comme *syslog*.


# Problématiques
Comme le processus est *isolé*, embarqué dans un container *Docker* ou dans un *IoT*, il faut pouvoir *sortir* de cet *isolation* pour pouvoir récupérer les *événements* de debug.

**ATTENTION:** si on passe par Internet, le *flux* n'est pas sécurisé ni chiffré. Ce n'est pas grave en soit car ce n'est que des *prints console* et provisoire le temps du *debug*.


# Moyens
Pour faire très simple on va utiliser la commande *socat* de Linux pour *détourner* ce qui arrive sur un *port* dans un *fichier*.<br>
Il suffit donc simplement, pour faire un *print console*, d'écrire dans un *port* du serveur pour *écrire* dans un fichier les informations de *debug*.


# Deux versions sont possibles

## Version simple
![Image](https://github.com/zuzu59/reclog/blob/master/img/reclog%20figure%201.jpg?raw=true)

Tout ce qui *arrive* sur un *port* est redirigé dans un fichier avec la commande *socat* (à faire tourner sur la machine *locale* ou *remote*). Simple et pratique quand on se trouve soit le même réseau ou alors que le fichier à observer se trouve sur un serveur sur Internet.
```
socat -u TCP4-LISTEN:port_reclog,reuseaddr,fork OPEN:./filename,creat,append
```
On peut l'utiliser facilement avec ce petit script bash:
```
reclog2file.sh port filename
```

### Test de la connexion
On peut tester la connexion avec un simple **telnet** (à faire tourner dans une autre console où tourne le *socat*):
```
telnet localhost port_reclog
```

et en suite un **tail -f** (à faire tourner dans une autre console où tourne le *socat*):
```
tail -f filename
```
Tout ce qui est *écrit* dans la console *telnet* va se retrouver *enregistré* dans le fichier sur la machine


## Version complexe avec un tremplin tunnel reverse ssh
![Image](https://github.com/zuzu59/reclog/blob/master/img/reclog%20figure%202.jpg?raw=true)

* tout ce qui *arrive* sur un port, d'un serveur sur Internet, est redirigé sur un autre *port* de la même machine, afin de pouvoir y crocher un *tunnel ssh reverse* pour déporter l'enregistrement du fichier sur sa machine locale. Cela permet d'utiliser un serveur *reclog* sur Internet et d'avoir le fichier de log sur sa machine de son réseau local sans devoir ouvrir un port sur le NAT de son routeur.

On *creuse* en premier un *tunnel ssh reverse* de sa machine en local au serveur qui se trouve sur Internet avec (à faire tourner dans une console sur sa machine locale):
```
ssh -R port_remote:localhost:port_local user@host_remote
```

Ce qui a maintenant *lié* le *port_local* de sa machine sur la machine *remote* sur Internet, mais c'est seulement réservé pour le *localhost* de la machine *remote* !<br>
Il faut donc publier le port *port_remote* sur le port *externe* de la machine remote afin qu'il soit utilisable depuis Internet avec la commande (à faire tourner dans une autre console sur sa machine locale):
```
ssh -t user@host_remote ssh -g -N -L port_reclog:localhost:port_remote localhost
```

Enfin on redirige tout ce qui arrive sur le *port_local* de sa machine dans un fichier avec la commande *socat* (à faire tourner dans une autre console sur sa machine locale):
```
socat -u TCP4-LISTEN:port_local,reuseaddr,fork OPEN:./filename,creat,append
```

On peut le faire facilement avec ce petit script bash (à faire tourner sur sa machine *locale*):
```
reclog2remote2file.sh user@host_remote port_reclog port_remote port_local filename
```

Ce script va tout lancer les commandes sur la machine *remote* depuis sa machine *locale* en *tâche de fond*. Après avoir terminé avec le *reclog*, on peut tout arrêter avec ce petit script:
```
reclog_remote_kill.sh
```


## Test de la connexion
On peut tester la connexion avec un simple **telnet** (à faire tourner dans une autre console sur sa machine locale):
```
telnet host_remote port_reclog
```

et en suite un **tail -f** (à faire tourner dans une autre console sur sa machine locale):
```
tail -f filename
```
Tout ce qui est *écrit* dans la console *telnet* va se retrouver *enregistré* dans le fichier sur sa machine


