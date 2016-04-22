mysql:
  server:
    root_password: 'somepass'
    mysqld:
      bind-address: 0.0.0.0

  database:
    - efhapp
  schema:
    efhapp:
      load: True
      source: salt://mysql/files/efhdb.sql

  user:
    efhapp:
      password: 'somepass'
      host: '%'
      databases:
        - database: efhapp
          grants: ['select', 'insert', 'update']
