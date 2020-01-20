#!/bin/sh
#full script, assuming node is available.

ts=`date '+%Y-%m-%d_%H:%M'`
cm="konopas.appcache"
gt="data/program.json"
gtp="data/participants.json"
tm="$gt.$ts"
tmp="$gtp.$ts"

# The Grenadine JSON API url seems to have gotten a bit simpler.
grenadine_prog_url="https://boskone.grenadine.co/en/boskone57/program.json?scale=2.0"
grenadine_peep_url="https://boskone.grenadine.co/en/boskone57/program/participants.json?scale=2.0"

cd /home/nesfa/konopas/

curl "$grenadine_prog_url" > "$tm" 2>/dev/null
curl "$grenadine_peep_url" > "$tmp" 2>/dev/null

if  ! diff "$tm" "$gt" >/dev/null 2>&1  ||  ! diff "$tmp" "$gtp" >/dev/null 2>&1 
then
	cp "$tm" "$gt"
	cp "$tmp" "$gtp"
	cd /home/nesfa/konopas/data/
	# do the conversion
	/opt/nodejs/bin/node program2program.js
	/opt/nodejs/bin/node participants2people.js
	cd /home/nesfa/konopas/
	# update the manifest
	d=`date`
	sed -i "s/^# .*/# $d/" $cm 2>/dev/null
else
	rm "$tm" "$tmp"
fi
