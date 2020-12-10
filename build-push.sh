#! /bin/bash

SPARK_VERSIONS=(
    "2.4.0-hadoop2.7"
    "2.4.1-hadoop2.7"
    "2.4.3-hadoop2.7"
    "2.4.4-hadoop2.7"
    "2.4.5-hadoop2.7"
    "3.0.0-hadoop3.2"
    "3.0.1-hadoop3.2"
)

echo "Enter you dockerhub credentials"
read -p "Username:" username
read -s -p "Password:" password
echo ""

echo "${password}" | docker login --username "${username}" --password-stdin

for SPARK_VERSION in ${SPARK_VERSIONS[@]}; do
    echo "Build with tag ${SPARK_VERSION}"
    docker build --build-arg "SPARK_VERSION=${SPARK_VERSION}" \
        -t "chimerasuite/thriftserver:${SPARK_VERSION}" . 
    docker push "chimerasuite/thriftserver:${SPARK_VERSION}"
done