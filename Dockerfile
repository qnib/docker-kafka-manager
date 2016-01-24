FROM qnib/u-java8

RUN apt-get install -y wget
RUN wget -qO /tmp/kafka-manager_1.3.0.4_all.deb https://packagecloud.io/spuder/kafka-manager/packages/ubuntu/trusty/kafka-manager_1.3.0.4_all.deb/download && \
    dpkg -i /tmp/kafka-manager_1.3.0.4_all.deb && \
    rm -f /tmp/kafka-manager_1.3.0.4_all.deb
ADD etc/supervisord.d/kafka-manager.ini /etc/supervisord.d/
ADD opt/qnib/kafka-manager/bin/start_kafka-manager.sh /opt/qnib/kafka-manager/bin/
ADD etc/consul.d/kafka.json /etc/consul.d/
#ADD conf/application.conf /usr/share/kafka-manager/conf/
