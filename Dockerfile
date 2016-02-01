FROM qnib/java8:cos7


ENV SCALA_VERSION=2.11.7 \
    KMGR_VER=1.3.0.4
RUN \
  curl -fso /tmp/scala.tgz http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz && \
  tar xzf /tmp/scala.tgz -C /opt/ && \
  rm -f /tmp/scala.tgz && \
  echo >> /root/.bashrc && \
  echo 'export PATH=/opt/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN curl -o /etc/yum.repos.d/bintray-sbt-rpm.repo  https://bintray.com/sbt/rpm/rpm

RUN yum install -y bsdtar sbt 
Run yum install -y java-1.8.0-openjdk-devel
RUN curl -fsL https://github.com/yahoo/kafka-manager/archive/${KMGR_VER}.zip |bsdtar xf - -C /opt/ && \
    mv /opt/kafka-manager-${KMGR_VER} /opt/kafka-manager/
RUN cd /opt/kafka-manager/ && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    sbt clean dist
RUN cd /opt/ && \
    unzip /opt/kafka-manager/target/universal/kafka-manager-${KMGR_VER}.zip && \
    rm -rf /opt/kafka-manager/ && \
    mv /opt/kafka-manager-${KMGR_VER} /opt/kafka-manager/
ADD etc/supervisord.d/kafka-manager.ini /etc/supervisord.d/
ADD opt/qnib/kafka-manager/bin/start_kafka-manager.sh /opt/qnib/kafka-manager/bin/
ADD etc/consul.d/kafka.json /etc/consul.d/
ADD conf/application.conf /opt/kafka-manager/conf/
