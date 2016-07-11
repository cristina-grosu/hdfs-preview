#!/bin/bash


HADOOP_HOME="opt/hadoop"
HADOOP_SBIN_DIR="opt/hadoop/sbin"
HADOOP_CONF_DIR="opt/hadoop/etc/hadoop"

. "/root/.bashrc"

if [ "$HOSTNAME" = "" ]; then
  HOSTNAME=`hostname -f`
fi

if [ "$MODE" = "" ]; then
MODE=$1
fi

if [ "$MODE" == "headnode" ]; then 
	
	/opt/hadoop/bin/hdfs namenode -format
	#${HADOOP_SBIN_DIR}/hadoop-daemons.sh --config "$HADOOP_CONF_DIR" --hostnames "spark.marathon.mesos" --script "/opt/hadoop/bin/hdfs" start namenode
	${HADOOP_SBIN_DIR}/hadoop-daemons.sh --config "$HADOOP_CONF_DIR" --hostnames $HOSTNAME --script "/opt/hadoop/bin/hdfs" start namenode
	
elif [ "$MODE" == "datanode" ]; then
	
	${HADOOP_SBIN_DIR}/hadoop-daemons.sh --config "$HADOOP_CONF_DIR" --script "/opt/hadoop/bin/hdfs" start datanode
	
else
	/opt/hadoop/bin/hdfs namenode -format
	#${HADOOP_SBIN_DIR}/hadoop-daemons.sh --config "$HADOOP_CONF_DIR" --hostnames "spark.marathon.mesos" --script "/opt/hadoop/bin/hdfs" start namenode
	${HADOOP_SBIN_DIR}/hadoop-daemons.sh --config "$HADOOP_CONF_DIR" --hostnames $HOSTNAME --script "/opt/hadoop/bin/hdfs" start namenode
	${HADOOP_SBIN_DIR}/hadoop-daemons.sh --config "$HADOOP_CONF_DIR" --script "/opt/hadoop/bin/hdfs" start datanode
fi
Status 