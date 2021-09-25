#!/usr/bin/env python

from sys import path
import yaml
import json
import os
import sys

file_path = os.path.dirname(os.path.realpath(__file__))

allvarspath = os.path.join(file_path,"bootstrap","environments","development",
    "group_vars","all")

with open(allvarspath,"r") as f:
    content = f.read()

allvars = yaml.load(content,Loader=yaml.Loader)

nodes = [
    f"compute-{i+1}" for i in range(allvars['num_computes'])
]

nodes.append("ldap")
nodes.append("nas")

os.system("cat /dev/zero | ssh-keygen -q -N \"\"")

for node in nodes:
    os.system(f"sshpass -p vagrant ssh-copy-id root@{node}")