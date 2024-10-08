#!/bin/bash
export HOME=/config

# "fix" homedir for app user as Eclipse ignores $HOME (Java user.home != $HOME)
#sed -i "/^${APP_USER}:/ { s#/dev/null#${HOME}# }" /etc/passwd
take-ownership /config
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

exec /opt/eclipse/eclipse -vmargs "-Duser.home=$HOME"
