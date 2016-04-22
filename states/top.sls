base:
  'web*':
    - php.mysql
    - apache
    - apache.mod_php5
    - apache.vhosts.standard
    - apache.mod_rewrite
    - efhapache.remove_default
    - efhapache.deploy_app

  'mysql*':
    - mysql.server
    - mysql.remove_test_database
    - mysql.user
    - mysql.database

  'balancer*':
    - haproxy
    - efhbalancer.scaler
