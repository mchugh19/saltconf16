include:
  - apache

remove_default:
  file.absent:
    - name: /etc/apache2/sites-enabled/000-default.conf
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-reload
