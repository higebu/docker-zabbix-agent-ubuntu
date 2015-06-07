FROM ubuntu:trusty

RUN apt-get update && apt-get install -y wget \
    && wget http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb \
    && dpkg -i zabbix-release_2.4-1+trusty_all.deb \
    && apt-get update && apt-get install -y zabbix-agent \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f zabbix-release_2.4-1+trusty_all.deb

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 10050

ENTRYPOINT ["/docker-entrypoint.sh"]
