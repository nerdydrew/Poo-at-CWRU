// Requests user's geolocation and calls the appropriate function.
// http://diveintohtml5.info/geolocation.html
function getLocation() {
	if(navigator.geolocation) {
		document.getElementById("geolocation").innerHTML="<p class=\"loading\">Trying to get location<span>.</span><span>.</span><span>.</span></p>";
		navigator.geolocation.getCurrentPosition(findNear, errorHandler, {maximumAge: 30000});
	} else {
		document.getElementById("geolocation").innerHTML="<p class=\"warning\">Your browser may not support geolocation.</p>";
	}
}


// Takes in a coordinate position and uses AJAX.
function findNear(pos) {
	document.getElementById("geolocation").innerHTML="<p class=\"loading\">Location found. Determining nearest toilets<span>.</span><span>.</span><span>.</span></p";

	var url="/util/geolocation/" + pos.coords.latitude + "/" + pos.coords.longitude;

	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
	} else { // code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }

	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200) {
			document.getElementById("geolocation").innerHTML=xmlhttp.responseText;
		};
	};

	xmlhttp.open("GET",url,true);
	xmlhttp.send();
}

function errorHandler(error) {
	if (error.code == 1)
		var message = "<p class=\"warning\">If you don&rsquo;t let us see your location, we can&rsquo;t find a nearby toilet!</p>";
	else {
		var message = "<p class=\"warning\">There was a problem finding your location.</p>";
	}

	document.getElementById("geolocation").innerHTML=message;
}
