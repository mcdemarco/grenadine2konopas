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
tgf="/var/www/html/data/program.js"
tgfp="/var/www/html/data/people.js"
tm="$gt.$ts"
tmp="$gtp.$ts"

# The Grenadine JSON API url seems to have gotten a bit simpler.
grenadine_prog_url="https://boskone.grenadine.co/en/boskone57/program.json?scale=2.0"
grenadine_peep_url="https://boskone.grenadine.co/en/boskone57/program/participants.json?scale=2.0"

#Kindly hosted by Discon 3
cd ~

curl "$grenadine_prog_url" > "$tm" 2>/dev/null
curl "$grenadine_peep_url" > "$tmp" 2>/dev/null

if  ! diff "$tm" "$gt" >/dev/null 2>&1  ||  ! diff "$tmp" "$gtp" >/dev/null 2>&1 
then
	cp "$tm" "$gt"
	cp "$tmp" "$gtp"
	# run the conversion now; the scripts should be in the same directory
	~/.nvm/versions/node/v13.7.0/bin/node program2program.js
	~/.nvm/versions/node/v13.7.0/bin/node participants2people.js
	# don't try to update the manifest; it's elsewhere.
#	d=`date`
#	sed -i "s/^# .*/# $d/" $cm 2>/dev/null
	# move the files
	cp "$tgt" "$tgf"
	cp "$tgtp" "$tgfp"
else
	rm "$tm" "$tmp"
fi
