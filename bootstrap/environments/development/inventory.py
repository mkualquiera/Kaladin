#!/usr/bin/env python

from sys import path
import yaml
import json
import os
import sys

file_path = os.path.dirname(os.path.realpath(__file__))

allvarspath = os.path.join(file_path,"group_vars",
    "all")

with open(allvarspath,"r") as f:
    content = f.read()

allvars = yaml.load(content,Loader=yaml.Loader)

result = {}

if '--list' in sys.argv:
    result = {
        "cluster": {
            "children": [
                "management",
                "computes"
            ]
        },
        "management": {
            "children": [
                "radiant",
                "nas",
                "ldap",
            ]
        },
        "radiant": {
            "hosts": [
                "radiant"
            ]
        },
        "nas": {
            "hosts": [
                "nas"
            ]
        },
        "ldap": {
            "hosts": [
                "ldap"
            ]
        },
        "computes": {
            "hosts": [
                f"compute-{i+1}" for i in range(allvars['num_computes'])
            ]
        }
    }

print(json.dumps(result))