FROM java:openjdk-7-jdk
MAINTAINER ng.tuna@gmail.com

ENV REFRESHED_AT 2015-11-13

RUN apt-get update -qq

ENV MAVEN_VERSION 3.3.3

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    && tar xzf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/share \
    && rm -f apache-maven-$MAVEN_VERSION-bin.tar.gz \
    && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

RUN apt-get install -y git unzip

RUN wget http://mirrors.viethosting.vn/apache/camel/apache-camel/2.16.0/apache-camel-2.16.0-src.zip \
    && unzip apache-camel-2.16.0-src.zip \
    && rm -f apache-camel-2.16.0-src.zip

WORKDIR apache-camel-2.16.0

ENV MAVEN_OPTS "-Xmx1024m -XX:MaxPermSize=512m"

ENTRYPOINT ["mvn"]
CMD ["install"]
