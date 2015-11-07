#!/bin/sh

URL='http://localhost/nginx_status'
TMP='/tmp/nginx-ping.tmp'
ZABBIX_SENDER='/usr/bin/env zabbix_sender'
CONFIG='/etc/zabbix/zabbix_agentd.conf'

# WARNING: Correctly setup 'Hostname=' in config is REQUIRED!
# REQUIRED binaries: GNU time, wget, awk, zabbix_sender.

(/usr/bin/env time -f %e /usr/bin/env wget --no-http-keep-alive --quiet --timeout 9 -O - $URL) 2>$TMP | \
	awk '/Active connections/ {active=int($NF)}
		/ ([0-9]+) ([0-9]+) ([0-9]+)/ {accepts=int($1); handled=int($2); requests=int($3)}
		/Reading:/ {reading=int($2); writing=int($4); waiting=int($6)}
		END {
			print "- nginx.connections.active", active;
			print "- nginx.connections.reading", reading;
			print "- nginx.connections.writing", writing;
			print "- nginx.connections.waiting", waiting;
			print "- nginx.accepts", accepts;
			print "- nginx.handled", handled;
			print "- nginx.requests", requests;
		}' | $ZABBIX_SENDER --config $CONFIG \
			--input-file - >/dev/null 2>&1

[ -f $TMP ] && cat $TMP && rm $TMP

exit 1
