FROM qnib/java8:fd22

ENV SCALA_VERSION 2.11.7

# Install Scala
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz |tar xzf - -C /opt/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=/opt/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN curl -o /etc/yum.repos.d/bintray-sbt-rpm.repo  https://bintray.com/sbt/rpm/rpm

# Define working directory
RUN dnf install -y bsdtar sbt
ENV KMGR_VER=1.2.7
RUN curl -fsL https://github.com/yahoo/kafka-manager/archive/${KMGR_VER}.zip |bsdtar xf - -C /opt/ && \
    mv /opt/kafka-manager-${KMGR_VER} /opt/kafka-manager/
RUN cd /opt/kafka-manager/ && sbt clean dist

