#!/bin/sh

HOSTNAME=$1
SERVER=$2
HOST_METADATA=$3

if [ -z "$HOSTNAME" ]; then
    echo "Hostname is missing"
    exit 1
fi

if [ -z "$SERVER" ]; then
    echo "Server is missing"
    exit 1
fi

mkdir -p /etc/zabbix/zabbix_agentd.d

cat <<EOF > /etc/zabbix/zabbix_agentd.conf
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
LogFileSize=5
EnableRemoteCommands=1
Server=$SERVER
StartAgents=10
ServerActive=$SERVER
Hostname=$HOSTNAME
AllowRoot=1
Include=/etc/zabbix/zabbix_agentd.d/
EOF

if [ ! -z "$HOST_METADATA" ]; then
    echo "HostMetadata=$HOST_METADATA" >> /etc/zabbix/zabbix_agentd.conf
fi

zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
tail -F /var/log/zabbix/zabbix_agentd.log
