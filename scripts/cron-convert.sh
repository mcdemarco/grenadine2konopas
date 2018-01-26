#!/bin/sh
#a script to replace the grenadine konopas interface so sadly yanked after WorldCon,
#by grabbing the generic grenadine json and converting it to Konopas format with node scripts.
#
#It's a little weirder because we're running it on a different server which has command-line node,
#then writing the output to a public spot where the real server can pick the files.

ts=`date '+%Y-%m-%d_%H:%M'`
#cm="konopas.appcache"
gt="program.json"
gtp="participants.json"
tgt="program.js"
tgtp="people.js"
tgf="/home/hosting/public_html/schedule.arisia.org/data/program.js"
tgfp="/home/hosting/public_html/schedule.arisia.org/data/people.js"
tm="$gt.$ts"
tmp="$gtp.$ts"

# The underscore-to-hyphen may not be a permanent change.
grenadine_prog_url="https://boskone.grenadine.co:443/en/boskone-55/program.json?scale=2.0"
grenadine_peep_url="https://boskone.grenadine.co:443/en/boskone-55/program/participants.json?scale=2.0"

#Kindly hosted by Arisia
cd /home/hosting/zambia_scripts/nesfa

curl "$grenadine_prog_url" > "$tm" 2>/dev/null
curl "$grenadine_peep_url" > "$tmp" 2>/dev/null

if  ! diff "$tm" "$gt" >/dev/null 2>&1  ||  ! diff "$tmp" "$gtp" >/dev/null 2>&1 
then
	cp "$tm" "$gt"
	cp "$tmp" "$gtp"
	# run the conversion now; the scripts should be in the same directory
	/opt/nodejs/bin/node program2program.js
	/opt/nodejs/bin/node participants2people.js
	# don't try to update the manifest; it's elsewhere.
#	d=`date`
#	sed -i "s/^# .*/# $d/" $cm 2>/dev/null
	# move the files
	cp "$tgt" "$tgf"
	cp "$tgtp" "$tgfp"
else
	rm "$tm" "$tmp"
fi