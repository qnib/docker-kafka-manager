FROM qnib/java8:fd22

RUN yum install -y bsdtar sbt java-1.8.0-openjdk
ENV KMGR_VER=1.2.7
RUN curl -fsL https://github.com/yahoo/kafka-manager/archive/${KMGR_VER}.zip |bsdtar xf - -C /opt/ && \
    mv /opt/kafka-manager-${KMGR_VER} /opt/kafka-manager/
RUN cd /opt/kafka-manager/ && sbt clean dist

