#!/bin/sh
#Cron script to check for new Konopas data, plus update the manifest if we found data changes.
#
#Picks up the program and participant files from our mule rather than directly from grenadine.
#Still does a diff.
#current cron setting is:
#7,22,37,52 * * * * /bin/sh /home/nesfa/konopas_scripts/cron-check-update-manifest.sh

ts=`date '+%Y-%m-%d_%H:%M'`
cm="konopas.appcache"
tgt="data/program.js"
tgtp="data/people.js"
tm="$tgt.$ts"
tmp="$tgtp.$ts"

# Converted files kindly hosted by Arisia.
remote_prog_url="https://schedule.arisia.org/data/program.js"
remote_peep_url="https://schedule.arisia.org/data/people.js"

cd /home/nesfa/konopas/

curl "$remote_prog_url" > "$tm" 2>/dev/null
curl "$remote_peep_url" > "$tmp" 2>/dev/null

if  ! diff "$tm" "$tgt" >/dev/null 2>&1  ||  ! diff "$tmp" "$tgtp" >/dev/null 2>&1 
then
	cp "$tm" "$tgt"
	cp "$tmp" "$tgtp"
	d=`date`
	sed -i "s/^# .*/# $d/" $cm 2>/dev/null
else
	rm "$tm" "$tmp"
fi
