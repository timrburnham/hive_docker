#!/bin/sh
/usr/hdp/current/hive-server2/bin/hiveserver2 \
    --hiveconf hive.server2.authentication=NONE \
    --hiveconf hive.server2.enable.doA=false \
    --hiveconf hive.server2.transport.mode=BINARY \
    --hiveconf fs.hdfs.impl.disable.cache=true \
    --hiveconf fs.file.impl.disable.cache=true > /tmp/hive/hive.out 2> /tmp/hive/hive.err &

tail -F /tmp/hive/hive.log