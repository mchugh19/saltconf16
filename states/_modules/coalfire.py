def report():
  report = []

  report.append("!Request ID")
  report.append(__grains__['osfullname'])
  report.append(__grains__['osfinger'])
  report.append("!Role")
  report.append(__grains__['host'])
  ips = ','.join(__grains__['fqdn_ip4'])
  report.append(ips)
  report.append("!Datacenter")
  report.append("!Owner")
  report.append(__grains__['osrelease'])
  addresses = ','.join(__grains__['ipv4'])
  report.append(addresses)
  report.append(__salt__['cmd.run']("ip addr | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append(__salt__['cmd.run']("netstat | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append(str(__salt__['pkg.list_pkgs']()))
  report.append(__salt__['cmd.run']("cat /etc/passwd | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append(__salt__['cmd.run']("grep -v '^#' /etc/nsswitch.conf | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append("!GPO")
  report.append(__salt__['cmd.run']("grep -v '^#' /etc/pam.d/* | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append(__salt__['cmd.run']("grep -v '^#' /etc/rsyslog.conf | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append(__salt__['cmd.run']("grep -v '^#' /etc/rsyslog.d/* | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append(str(__salt__['pkg.version']('ntp')))
  report.append(__salt__['cmd.run']("cat /etc/ntpd.conf | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append(str(__salt__['service.get_all']()))
  report.append(__salt__['cmd.run']("iptables --list | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append(str(__salt__['pkg.list_pkgs']()))
  report.append(__salt__['cmd.run']("netstat -plnt | sed ':a;N;$!ba;s/\\n/,/g'", python_shell=True))
  report.append(str(__salt__['mount.active']()))

  if __grains__['kernel'] == 'Linux':
    report.append(__salt__['cmd.run']('grep ^ENCRYPT_METHOD /etc/login.defs | sed \':a;N;$!ba;s/\\n/,/g\'', python_shell=True))
  #elif __grains__['kernel'] == 'Windows':
    #report.append('!NA')

  report.append("!ConsoleTimeout")
  report.append("!NonConsoleTimeout")

  return '&'.join(report)
