#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Petit script pour l'écriture dans un socket sur Internet
# zf200831.1600

import socket                

print("début du programme...")

s = socket.socket()    
try:
    # print("connexion 1")
    s.connect(('www.zuzu-test.ml', 55514))
    s.send(b'hello zuzu 1601.1\n') 
    s.close()   
except socket.error as e:
    pass
    # print("oups..." + str(e))
    
    
s = socket.socket()    
try:
    # print("connexion 2")
    s.connect(('www.zuzu-test.ml', 55514))
    s.send(b'hello zuzu 1601.2\n') 
    s.close()   
except socket.error as e:
    pass
    # print("oups..." + str(e))


print("suite du programme...")

