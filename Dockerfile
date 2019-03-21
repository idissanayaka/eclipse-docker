# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-18.04

# Install Eclipse
RUN apt-get update \
  && apt-get -y upgrade \
  && mkdir -p /usr/share/man/man1 \
  # sudo is for running mvn as user from docker-compose exec session.
  # e.g. docker-compose exec eclipse sudo -u ${USER} mvn test
  && apt-get install -y sudo curl bash perl maven openjdk-11-jdk \
  && curl -sL http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/2019-03/R/eclipse-java-2019-03-R-linux-gtk-x86_64.tar.gz | tar xz -C /opt/ \
  # only main window is maximized & frameless
  && sed-patch 's/<application type="normal">/<application type="normal" title="*Eclipse IDE*">/' /etc/xdg/openbox/rc.xml \
  && rm -rf /var/lib/apt/lists/*

# Copy the start script.
COPY rootfs/ /

# Set the name of the application.
ENV APP_NAME="Eclipse"
