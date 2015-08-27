FROM qnib/java7

RUN yum install -y bsdtar sbt 
RUN curl -fsL https://github.com/yahoo/kafka-manager/archive/master.zip |bsdtar xf - -C /opt/ && \
    mv /opt/kafka-manager-master /opt/kafka-manager/
RUN cd /opt/kafka-manager/ && sbt clean dist

