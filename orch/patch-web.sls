{% set target = salt['pillar.get']('target') %}

remove_web_ip_from_mine:
  salt.function:
    - name: mine.delete
    - tgt: {{ target }}
    - arg: 
      - network.ip_addrs

remove_web_from_balancer:
  salt.state:
    - tgt: 'balancer*'
    - sls:
      - haproxy
    - require:
      - salt: remove_web_ip_from_mine

patch_web1:
  salt.function:
    - name: cmd.run
    - tgt: {{ target }}
    - arg:
      - echo sleeping
    - require:
      - salt: remove_web_from_balancer

patch_web2:
  salt.function:
    - name: cmd.run
    - tgt: {{ target }}
    - arg:
      - sleep 10
    - require:
      - salt: patch_web1

add_web_ip_to_mine:
  salt.function:
    - name: mine.update
    - tgt: {{ target }}
    - require:
      - salt: patch_web2

add_web_to_balancer:
  salt.state:
    - tgt: 'balancer*'
    - sls:
      - haproxy
    - require:
      - salt: add_web_ip_to_mine

