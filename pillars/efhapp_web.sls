mine_functions:
  network.ip_addrs: []
  test.ping: []

apache:
  global:
    AllowEncodedSlashes: "On"
  sites:
    efhapp:
      template_file: salt://apache/vhosts/standard.tmpl
