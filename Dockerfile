# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-24.04-v4.6.4

COPY keybindings.xml /tmp/

# Install Eclipse
RUN apt-get update \
  && apt-get -y upgrade \
  && mkdir -p /usr/share/man/man1 \
  # sudo is for running mvn as user from docker-compose exec session.
  # e.g. docker-compose exec eclipse sudo -u ${USER} mvn test
  && apt-get install -y sudo curl wget bash perl maven openjdk-11-jdk 

RUN apt install -y libswt-gtk-4-jni

RUN wget -O - 'https://mirror.kakao.com/eclipse/technology/epp/downloads/release/2024-09/R/eclipse-jee-2024-09-R-linux-gtk-x86_64.tar.gz' | tar xz -C /opt/ \
  # only main window is maximized & frameless
  # && sed-patch 's/<application type="normal">/<application type="normal" title="*Eclipse IDE*">/' /etc/xdg/openbox/rc.xml \
  # && sed-patch '/.chainQuitKey.C-g.\/chainQuitKey./r /tmp/keybindings.xml' /etc/xdg/openbox/rc.xml \
  # && rm /tmp/keybindings.xml \
  # && rm -rf /var/lib/apt/lists/*

# Copy the start script.
COPY rootfs/ /

# Set the name of the application.
ENV APP_NAME="Eclipse"
