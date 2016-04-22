# saltconf16 salt example

Assumes VMs exist named:
```
  - web1
  - web2 (shutdown)
  - mysql1
  - balancer1
```

#### First download the salt formulas used
```
mkdir /srv/forumlas
cd /srv/formulas
git clone https://github.com/saltstack-formulas/apache-formula.git
git clone https://github.com/saltstack-formulas/haproxy-formula.git
git clone https://github.com/saltstack-formulas/mysql-formula.git
git clone https://github.com/saltstack-formulas/php-formula.git
```

#### Configure salt master to use formulas and configure reactors
```
cp master.d/* /etc/salt/master.d/
```

#### Restart salt-master to activate master.d files
```
systemctl restart salt-master
```

#### Activate pillar files
```
cp pillars/* /srv/pillar
```

#### Copy states and top file to where salt can use them
```
cp -r states/* /srv/salt/
```

---
##### Deploy environment (web1, mysql1, balancer1)
```
salt-run state.orchestrate orch.stackdeploy
```

##### Create load on loadbalancer. This causes monitoring script on web1 to notice the 
##### load over threshold, and sends a message to the salt bus. The salt master reacts
##### to the event and spins up the additional web server and configures it as a duplicate of
##### web1.
```
ab -t 600 -n 1000000 -c 100 IP-OF-balancer1
```

##### Run simulated patch operation on web1 (host was just created so there isn't much to 
##### patch.
```
salt-run state.orchestrate orch.patch-web 'pillar={"target":"web1"}'
```

##### Run salt module to gather OS data and save to & seperated values file
##### (*Announced at saltconf16* Proper compliance reporting project: [http://hubblestack.io/])
```
salt '*' coalfire.report --output newline_values_only > /tmp/report.csv
```
