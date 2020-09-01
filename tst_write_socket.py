#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Petit script pour l'écriture dans un socket sur Internet
# zf200901.1055

import socket                

from datetime import datetime, timezone, timedelta

print("début du programme...")

ztimestamp = 'hello zuzu start: ' + str(datetime.now(timezone(timedelta(hours=2)))) + '\n'
print(ztimestamp)
s = socket.socket()    
try:
    print("connexion start")
    s.connect(('www.zuzu-test.ml', 55514))
    s.send(bytes(ztimestamp, encoding='utf-8')) 
    s.close()   
except socket.error as e:
    pass
    # print("oups..." + str(e))
    
    
ztimestamp = 'hello zuzu end: ' + str(datetime.now(timezone(timedelta(hours=2)))) + '\n'
print(ztimestamp)
s = socket.socket()    
try:
    print("connexion end")
    s.connect(('www.zuzu-test.ml', 55514))
    s.send(bytes(ztimestamp, encoding='utf-8')) 
    s.close()   
except socket.error as e:
    pass
    # print("oups..." + str(e))


print("suite du programme...")

