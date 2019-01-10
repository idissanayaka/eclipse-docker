# Pull base image.
FROM jlesage/baseimage-gui:debian-9

# Install Eclipse
RUN apt-get update \
  && mkdir -p /usr/share/man/man1 \
  && apt-get install -y curl openjdk-8-jdk \
  && curl -sL http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/2018-12/R/eclipse-java-2018-12-R-linux-gtk-x86_64.tar.gz | tar xz -C /opt/ \
  && sed-patch 's/<application type="normal">/<application type="normal" title="Eclipse">/' /etc/xdg/openbox/rc.xml
  && rm -rf /var/lib/apt/lists/*

# Copy the start script.
COPY rootfs/etc/profile.d/openjdk.sh /etc/profile.d/openjdk.sh
COPY startapp.sh /startapp.sh

# Set the name of the application.
ENV APP_NAME="Eclipse"
