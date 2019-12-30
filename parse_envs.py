#!/bin/python

import re, socket, hashlib
from os import environ



FILE_PATH = "{}/config/server.properties".format(environ['KAFKA_HOME'])
envvars = {}

startswith = re.compile("^[\w]+\.")
with open(FILE_PATH, "r") as f:
    for line in f:
        if startswith.match(line) is not None:
            key, value = line.strip().split("=", 1)
            envvars[key] = value

for key in environ:
    if key.startswith("kafka."):
        envvars[key.replace("kafka.", "")] = environ[key]

if environ.get('KAFKA_LOG_DIR'):
    envvars['log.dir'] = environ.get('KAFKA_LOG_DIR')

if envvars.get('reserved.broker.max.id') is None or envvars.get('reserved.broker.max.id') == "":
    envvars['reserved.broker.max.id'] = str(10**8)

if environ.get('broker.id') is None or environ.get('broker.id') == "":
    envvars['broker.id'] = str(int(hashlib.sha1(socket.gethostname().encode("UTF-8")).hexdigest(), 16) % (10 ** 8))

with open(FILE_PATH, "w+") as f:
    for key in envvars:
        f.write("{}={}\n".format(key, envvars[key]))