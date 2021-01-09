var fs = require('fs');
//e.g., https://boskone.grenadine.co:443/en/boskone-55/program.json?scale=2.0
var data = require('./program.json');

var out = [];
for (var d=0; d<data.length; d++) {
	var datum = data[d];
	//Almost identical to the grenadine format, but a slot in loc: is filled in incorrectly.
	if (!datum.hasOwnProperty("loc"))
		console.log("Item " + datum.id.toString() + ", " + datum.title + " missing location.");
	else if (!datum.hasOwnProperty("time") || datum.time == null)
		console.log("Item " + datum.id.toString() + ", " + datum.title + " missing time.");
	else {
		/*Fix nulls in participant descriptions if necessary.
		var people = datum.people;
		for (var p=0; p<people.length; p++) {
			if (people[p].description == null)
				people[p].description = "";
		}*/

		var result = {"id": datum.id.toString(),
								"title": datum.title,
								"themes": datum.themes,
								"desc": datum.desc || "",
								"format": datum.format,
								"datetime": datum.datetime,
								"date": datum.date,
								"day": datum.day,
								"time": datum.time,
								"mins": datum.mins,
								"loc": [datum.loc[0]],
								"tags": datum.tags,
								"people": datum.people};
		out.push(result);
	}
}
//console.log(out);
fs.writeFile('program.js', "var program = " + JSON.stringify(out) + ";", function (err) {
    if (err) 
        return console.log(err);
//    console.log('Wrote program.js');
});


