function getFloors() {
	var building = document.getElementById('buildingDropdown').value;

	var url="/util/floordropdown/" + building;

	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else { // code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	 	}

	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("floorDropdown").innerHTML=xmlhttp.responseText;
		};
	};

	xmlhttp.open("GET", url, true);
	xmlhttp.send();
}

function updateUrinals() {
	if (document.getElementById("female").checked || document.getElementById("other").checked) {
		document.getElementById("urinalContainer").style.display = "none";
	} else {
		document.getElementById("urinalContainer").style.display = "inline";
	}
}


document.getElementById('buildingDropdown').onchange = getFloors;

window.onload = updateUrinals();
document.getElementById('male').onchange = updateUrinals;
document.getElementById('female').onchange = updateUrinals;
document.getElementById('other').onchange = updateUrinals;
