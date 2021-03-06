#!/bin/sh
#Boskone 54 script that used the late great grenadine konopas interface.

ts=`date '+%Y-%m-%d_%H:%M'`
cm="konopas.appcache"
tgt="data/program.js"
tgtp="data/people.js"
tm="$tgt.$ts"
tmp="$tgtp.$ts"

grenadine_prog_url="https://boskone.grenadine.co/en/boskone-54/konopas/program.js"
grenadine_peep_url="https://boskone.grenadine.co/en/boskone-54/konopas/program/participants.js"

cd /home/nesfa/konopas/

curl "$grenadine_prog_url" > "$tm" 2>/dev/null
curl "$grenadine_peep_url" > "$tmp" 2>/dev/null

if  ! diff "$tm" "$tgt" >/dev/null 2>&1  ||  ! diff "$tmp" "$tgtp" >/dev/null 2>&1 
then
	cp "$tm" "$tgt"
	cp "$tmp" "$tgtp"
	d=`date`
	sed -i "s/^# .*/# $d/" $cm 2>/dev/null
else
	rm "$tm" "$tmp"
fi
