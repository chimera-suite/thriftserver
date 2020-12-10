ARG SPARK_VERSION
FROM bde2020/spark-base:${SPARK_VERSION}

LABEL maintainer="Emanuele Falzone <emanuele.falzone@polimi.it>"

RUN apk --no-cache add procps

COPY wait-for.sh /
COPY start.sh /

RUN chmod +x /wait-for.sh
RUN chmod +x /start.sh

EXPOSE 10000

CMD ["/start.sh"]