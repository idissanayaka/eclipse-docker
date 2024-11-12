FROM ireshmm/weblogic:12.1.3-developer AS weblogic

# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-24.04-v4.6.4

# Install Eclipse
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y sudo curl wget bash perl maven openjdk-8-jdk libswt-gtk-4-jni unzip git

RUN wget 'https://download.oracle.com/otn_software/oepe/12.2.1.9/photon/oepe-12.2.1.9-photon-distro-linux-gtk-x86_64.zip' -O /tmp/eclipse.zip

RUN mkdir -p /opt/eclipse \
  && unzip /tmp/eclipse.zip -d /opt/eclipse \
  && rm /tmp/eclipse.zip

RUN apt install -y locales && \
    sed-patch 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8

COPY rootfs/ /

# Install terminal plugin
RUN /opt/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director \
  -repository 'https://download.eclipse.org/tm/terminal/marketplace' \
  -installIU org.eclipse.tm.terminal.feature.feature.group \
  -destination /opt/eclipse/

COPY --from=weblogic /u01/oracle /u01/oracle

COPY --from=weblogic /usr/java/jdk1.8.0_431 /u01/jdk1.8

ENV JAVA_HOME="/u01/jdk1.8"

RUN take-ownership /u01

ENV APP_NAME="Eclipse"