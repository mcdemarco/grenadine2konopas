var fs = require('fs');
//e.g., https://boskone.grenadine.co:443/en/boskone-55/program/participants.json?scale=2.0
var data = require('./participants.json');
var imgURL = "https://cust-images.grenadine.co/grenadine/image/upload/";
//Grenadine knows these are suffixes but it mashes them into the name anyway, 
//so we have to parse them out again.
var suffixes = ["FN","RN","PhD","Ph.D.","M.D.","JR","Jr","Jr.","Sr.","M.Ed.","SJ","(she/her/hers)","III"];

var out = [];

for (var d=0; d<data.length; d++) {
	var datum = data[d];

	//It's all in the name.
	var prefix = datum.prefix || "";
	var suffix = "";
	var lastName = "";

	var tempNames = datum.name.trim().split(" ");
	if (suffixes.indexOf(tempNames[tempNames.length - 1]) > -1) {
		suffix = tempNames.pop();
	}
	//If there's only one name, don't make it the last name.
	if (tempNames.length > 1)
		lastName = tempNames.pop();
	var firstName = tempNames.join(" ");
	//Push to the array in the proper order.
	var nameArray = [firstName, lastName, prefix, suffix];

	//Other stuff.
	var result = {"id": datum.id.toString(),
								"name": nameArray,
								"bio": datum.bio.replace("\\\\r\\\\n","<br/>"),
								"links": {},
								"prog": datum.prog.map(function(ele){return ele.toString();})
							 };
	if (datum.links)
		result.links = {twitter: datum.links.twitterid,
												url: datum.links.url
									 };
	if (datum.detail_image)
		result.links.img = imgURL + datum.detail_image;
	out.push(result);
}
//console.log(out);
fs.writeFile('people.js', "var people = " + JSON.stringify(out) + ";", function (err) {
    if (err) 
        return console.log(err);
//    console.log('Wrote people.js');
});


