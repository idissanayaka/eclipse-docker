# FROM container-registry.oracle.com/middleware/weblogic:12.2.1.4-dev AS weblogic

# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-24.04-v4.6.4

# Update and install packages
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y sudo curl wget bash perl maven openjdk-8-jdk libswt-gtk-4-jni unzip git

# Configure locale
RUN apt install -y locales && \
    sed-patch 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8

# Install eclipse
RUN wget 'https://download.oracle.com/otn_software/oepe/12.2.1.9/photon/oepe-12.2.1.9-photon-distro-linux-gtk-x86_64.zip' -O /tmp/eclipse.zip
RUN mkdir -p /opt/eclipse \
  && unzip /tmp/eclipse.zip -d /opt/eclipse \
  && rm /tmp/eclipse.zip

# Rootfs
COPY rootfs/ /

# Install terminal plugin
RUN /opt/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director \
  -repository 'https://download.eclipse.org/tm/terminal/marketplace' \
  -installIU org.eclipse.tm.terminal.feature.feature.group \
  -destination /opt/eclipse/

# Make weblogic installation directory
RUN mkdir -p /u01/oracle && take-ownership /u01

ENV APP_NAME="Eclipse"