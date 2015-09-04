#!/bin/bash


cd /opt/kafka-manager/

if [ "X${KAFKA_ENV_ZK_DC}" != "X" ];then
    ZK_DC=${KAFKA_ENV_ZK_DC}
fi

if [ "X${ZK_DC}" != "X" ];then
    sed -i'' -e "s#kafka-manager.zkhosts=.*#kafka-manager.zkhosts=\"zookeeper.service.${ZK_DC}.consul:2181\"#" /opt/kafka-manager/conf/application.conf
else
    sed -i'' -e "s#kafka-manager.zkhosts=.*#kafka-manager.zkhosts=\"zookeeper.service.consul:2181\"#" /opt/kafka-manager/conf/application.conf
fi

./bin/kafka-manager -Dconfig.file=/opt/kafka-manager/conf/application.conf

