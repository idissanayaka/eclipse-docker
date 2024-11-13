#!/bin/bash
export HOME=/config

# "fix" homedir for app user as Eclipse ignores $HOME (Java user.home != $HOME)
#sed -i "/^${APP_USER}:/ { s#/dev/null#${HOME}# }" /etc/passwd
export JAVA_HOME="/u01/jdk"
export PATH=$JAVA_HOME/bin:$PATH
export SHELL=/usr/bin/bash

exec /opt/eclipse/eclipse -vmargs "-Duser.home=$HOME"