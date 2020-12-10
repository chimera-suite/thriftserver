#! /bin/bash

echo "Checking enviroment variables..."

function check {
    [ -z "$2" ] && echo "Need to set $1" && exit 1;
}

TIMEOUT=120

check SPARK_MASTER $SPARK_MASTER

echo "Done!"

echo "Waiting for Spark..."

set -e

./wait-for.sh "$SPARK_MASTER" --timeout=120

echo "Spark is ready!"

echo "Starting thriftserver..."

/spark/bin/spark-submit --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 \
	--name "Thrift JDBC/ODBC Server" \
	--master "spark://$SPARK_MASTER:7077" \
	--deploy-mode client \
	--total-executor-cores 1 \
	--hiveconf hive.server2.thrift.port=10000 \
	--hiveconf hive.server2.thrift.bind.host=0.0.0.0