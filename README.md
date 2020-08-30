# reclog
Système très simple d'enregistrement de logs via le réseau

zf200830.1353

# ATTENTION, en cours de rédaction !


<!-- TOC titleSize:2 tabSpaces:2 depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 skip:1 title:1 charForUnorderedList:* -->
## Table of Contents
* [ATTENTION, en cours de rédaction !](#attention-en-cours-de-rédaction-)
* [Buts](#buts)
* [Moyens](#moyens)
  * [Deux versions sont possibles](#deux-versions-sont-possibles)
* [Version simple en local](#version-simple-en-local)
* [Version complexe avec le tremplin](#version-complexe-avec-le-tremplin)
* [Test de la connexion](#test-de-la-connexion)
<!-- /TOC -->


# Buts
*reclog* permet très simplement d'enregistrer des événements à distance via un *socket*, un peu suivant le même principe que *syslog*.


# Moyens
Pour faire très simple on va utiliser la commande *socat* de Linux pour détourner ce qui arrive sur un port dans un fichier.<br>
Il suffit donc de simplement écrire dans une port du serveur pour sauvegarder dans un fichier les informations désirées.

## Deux versions sont possibles
* tout ce qui *arrive* sur un *port* est redirigé dans un fichier. Simple et pratique quand on se trouve sur le même réseau.
* tout ce qui *arrive* sur un port est redirigé sur un autre *port* de la même machine, afin de pouvoir y crocher un *tunnel ssh* pour déporter le fichier d'enregistrement. Cela permet d'utiliser une machine *tremplin* sur Internet pour avoir le fichier de log en *local* sur sa machine sur Intranet sans devoir ouvrir un port sur son NAT.

# Version simple en local
On redirige tout ce qui arrive sur un *port* dans un fichier avec la commande *socat*:
```
socat TCP4-LISTEN:55514,reuseaddr,fork OPEN:./file.log,creat,append
```
On peut l'utiliser facilement avec ce petit script bash:
```
reclog2file.sh port filename
```

# Version complexe avec le tremplin
On redirige tout ce qui arrive sur un *port* d'une machine sur Internet sur un autre *port* de la même machine avec la commande *socat* (à faire tourner sur la machine *remote*):
```
socat TCP-LISTEN:55514,reuseaddr,fork TCP-LISTEN:55614,reuseaddr,bind=127.0.0.1
```

Puis après on creuse un *tunnel ssh* entre la machine *locale* et la machine *remote* afin de transporter le *port* du *reclog* sur sa machine *locale* (à faire tourner sur sa machine *locale*):
``` 
ssh -N -L 55514:localhost:55614 user@machine_remote &
```

Et enfin on redirige tout ce qui arrive sur le *port* de sa machine *locale* dans un fichier avec la commande *socat* (à faire tourner sur sa machine locale):
```
socat TCP4-LISTEN:55514,reuseaddr,fork OPEN:./file.log,creat,append
```

On peut l'utiliser facilement avec ce petit script bash (à faire tourner sur sa machine *locale*):
```
reclog2tremplin2file.sh user@machine_remote port_remote_in port_remote_out port_local filename
```

Ce script va tout lancer les commandes sur la machine *remote* depuis sa machine *locale* en *tâche de fond*. Après avoir terminé avec le reclog, on peut tout arrêter avec ce petit script:
```
reclog_remote_kill.sh
```

# Test de la connexion

simplement avec un telnet

et un tail -f







