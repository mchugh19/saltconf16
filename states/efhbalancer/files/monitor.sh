#!/bin/sh

OUTPUT=$(curl -s "http://localhost:8998/admin?stats;csv" | cut -d, -f 2,5 | grep web)
for host in $OUTPUT; do
    load=$(echo $host | cut -d, -f 2)
    if [ $load -gt 85 ];then
        #echo "HIGH LOAD"
        salt-call event.send 'efhapp/haproxy/highload'
    fi
done
