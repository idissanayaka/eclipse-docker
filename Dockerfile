# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-24.04-v4.6.4

# Install Eclipse
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y sudo curl wget bash perl maven openjdk-11-jdk libswt-gtk-4-jni

RUN wget -O - 'https://mirror.kakao.com/eclipse/technology/epp/downloads/release/2024-09/R/eclipse-jee-2024-09-R-linux-gtk-x86_64.tar.gz' | tar xz -C /opt/

COPY rootfs/ /

ENV APP_NAME="Eclipse"