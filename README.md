# grenadine2konopas

[Grenadine](https://events.grenadine.co) once had an API for use with [KonOpas](http://konopas.org), but now has a more generic JSON API.  These are some scripts we wrote for Boskone to convert between the two formats.  Your mileage may vary.

## Requirements

**Node.**  You don't need to run a webserver, just use command-line Node.

## Examples

There's sample input (`*.json`) and output (`*.js`) in the examples directory.

### Manual conversion

If you want to do the conversion manually, you can install Node on any machine that will run it and convert there.

1. Check out this project as well.
2. Open the Grenadine data in your browser from the URLs for Program and Participants listed in Grenadine under Your Event | Publishing | Publish On Your Own Web Site | JSON APIs | Type 1.
3. Save the data to two files named `program.json` and `participants.json` in the konopas subdirectory of this project.
4. Change to the konopas subdirectory.
5. Type the command `node participants2people.js`.
6. Type the command `node program2program.js`.

Barring errors, this will write the output files, `people.js` and `program.js` respectively, in the same directory.  You can then move them to the data directory of your KonOpas instance.

### Automated conversion

**Bash.**  There are a few bash scripts included to do one or more of: fetching the Grenadine data (hourly, or whenever), checking if it has changed, converting it, writing it to the KonOpas data directory, and updating the KonOpas cache manifest.  

To install any of these, you should have access to and understand the crontab.

* `cron-convert.sh` only does the retrieval, difference check, and conversion 
* `cron-convert-update-manifest.sh` does the conversion and manifest update
* `cron-check-update-manifest.sh` only does the retrieval and manifest update
* `cron-check-update-manifest-old.sh` is how it used to work, for the record

## Configuration

A short list of possible suffixes is included in `konopas/participants2people.js`; you may want to add more manually if your participants' suffixes are being misread as surnames.

## Build

There is no build process and there are no requirements; the scripts should run as-is as long as Node itself is installed.

