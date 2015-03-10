FROM ubuntu:14.04
MAINTAINER David Johnson "cdcttr@gmail.com"

RUN apt-get update && apt-get install ca-certificates curl -y 
RUN apt-get clean && apt-get --purge autoremove && rm -rf /var/lib/apt/lists/*

ENV VERSION 8
ENV UPDATE 40
ENV BUILD 25

RUN curl --silent --location --retry 3 --cacert /etc/ssl/certs/GeoTrust_Global_CA.pem \
    --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    http://download.oracle.com/otn-pub/java/jdk/"${VERSION}"u"${UPDATE}"-b"${BUILD}"/jdk-"${VERSION}"u"${UPDATE}"-linux-x64.tar.gz \
     | tar xz -C /tmp

ENV JAVA_HOME /usr/lib/jvm/java-${VERSION}-oracle

RUN mkdir -p /usr/lib/jvm && mv /tmp/jdk1.${VERSION}.0_${UPDATE} "${JAVA_HOME}"
RUN update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1
RUN update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 1
RUN update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1
RUN update-alternatives --install "/usr/bin/jar" "jar" "${JAVA_HOME}/bin/jar" 1
RUN update-alternatives --set java "${JAVA_HOME}/bin/java"
RUN update-alternatives --set javaws "${JAVA_HOME}/bin/javaws"
RUN update-alternatives --set javac "${JAVA_HOME}/bin/javac"
RUN update-alternatives --set jar "${JAVA_HOME}/bin/jar"

RUN rm -rf /tmp/* && rm -rf /var/tmp/*
