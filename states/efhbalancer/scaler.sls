deploy-script:
  file.managed:
    - name: /usr/local/bin/monitor.sh
    - source: salt://efhbalancer/files/monitor.sh
    - user: root
    - group: root
    - mode: 755

/usr/local/bin/monitor.sh:
  cron.present:
    - identifier: monitor-haproxy
    - user: root
    - minute: '*/2'
