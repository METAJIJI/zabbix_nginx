# Description
Monitoring nginx via zabbix agent.

# Dependencies
Required GNU time, awk, wget.

Install packages if not installed.

For `deb` based e.g. ubuntu, debian:
```
apt-get install time wget
```

For `rpm` based e.g. centos, fedora, suse:
```
yum install time wget
```

# Installation

```
mkdir /etc/zabbix/scripts
chown zabbix:zabbix /etc/zabbix/scripts
cp zabbix/scripts/nginx_status.sh /etc/zabbix/scripts
cp nginx/nginx_status_http.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/nginx_status_http.conf /etc/nginx/sites-enabled/nginx_status_http.conf
service nginx reload
service zabbix-agent restart
```
Goto zabbix web gui and import template for you zabbix version from `template` directory.
