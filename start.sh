#!/bin/sh
export HADOOP_HEAPSIZE=1024

/usr/hdp/current/hive-server2/bin/hiveserver2 > /tmp/hive/hive.out 2> /tmp/hive/hive.err &
sleep 5
tail -F /tmp/hive/hive.log