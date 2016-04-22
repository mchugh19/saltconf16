/var/www/efhapp/index.php:
  file.managed:
    - source: salt://efhapache/files/index.php
    - template: jinja
    - user: root
    - group: root
    - mode: 644
