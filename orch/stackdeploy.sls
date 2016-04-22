webserver_setup:
  salt.state:
    - tgt: 'web*'
    - highstate: True
    - require:
      - salt: db_setup

mine.update:
  salt.function:
    - tgt: 'web*'
    - require:
      - salt: webserver_setup

db_setup:
  salt.state:
    - tgt: 'mysql*'
    - highstate: True

balancer_setup:
  salt.state:
    - tgt: 'balancer*'
    - highstate: True
    - require:
      - salt: mine.update
