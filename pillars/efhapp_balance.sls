haproxy:
  enabled: True
  config_file_path: /etc/haproxy/haproxy.cfg
  global:
    stats:
      enable: True
      socketpath: /var/run/haproxy.sock
      level: admin

  listens:
    stats:
      bind:
        - "0.0.0.0:8998"
      mode: http
      stats:
        enable: True
        uri: "/admin?stats"
        refresh: "20s"

  frontends:
    frontend1:
      name: www-http
      bind: "*:80"
      default_backend: www-backend

  backends:
    backend1:
      name: www-backend
      balance: roundrobin
      servers:
        {% for server, addrs in salt['saltutil.runner']('mine.get', tgt='web*', fun='network.ip_addrs').items() %}
        {{ server }}:
          name: {{ server }}
          host: {{ addrs[0] }}
          port: 80
          check: check
        {% endfor %}
