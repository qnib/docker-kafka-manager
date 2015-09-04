FROM qnib/java8


ENV SCALA_VERSION=2.11.7 \
    KMGR_VER=1.2.7
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz |tar xzf - -C /opt/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=/opt/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN curl -o /etc/yum.repos.d/bintray-sbt-rpm.repo  https://bintray.com/sbt/rpm/rpm

RUN yum install -y bsdtar sbt 
RUN curl -fsL https://github.com/yahoo/kafka-manager/archive/${KMGR_VER}.zip |bsdtar xf - -C /opt/ && \
    mv /opt/kafka-manager-${KMGR_VER} /opt/kafka-manager/
RUN cd /opt/kafka-manager/ && sbt clean dist
RUN cd /opt/ && \
    unzip /opt/kafka-manager/target/universal/kafka-manager-1.2.7.zip && \
    rm -rf /opt/kafka-manager/ && \
    mv /opt/kafka-manager-1.2.7 /opt/kafka-manager/
ADD etc/supervisord.d/kafka-manager.ini /etc/supervisord.d/
ADD opt/qnib/kafka-manager/bin/start_kafka-manager.sh /opt/qnib/kafka-manager/bin/
