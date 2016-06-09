#!/bin/bash

cd /usr/share/kafka-manager/


consul-template -once -template "/etc/consul-templates/kafka/manager/application.conf.ctmpl:/usr/share/kafka-manager/conf/application.conf"


./bin/kafka-manager -Dconfig.file=./conf/application.conf

