FROM ubuntu:16.04

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu xenial main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe\n" >> /etc/apt/sources.list

#======================================
# Create the main user.
#======================================
RUN useradd -m --home-dir /germanium germanium

#================================================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#================================================
RUN apt-get update -qqy \
  && apt-get upgrade -y \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-8-jdk-headless \
    sudo \
    unzip \
    curl \
    wget \
    locales \
  && locale-gen en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LC_LANG="en_US.UTF-8"

#======================================
# Install maven
#======================================
ARG MAVEN_VERSION=3.5.3
ARG USER_HOME_DIR="/germanium"
ARG SHA=b52956373fab1dd4277926507ab189fb797b3bc51a2a267a193c931fffad8408
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

USER germanium
