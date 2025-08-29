const GENDER_COOKIE_NAME = "gender";
const MALE_VALUE = "male";
const FEMALE_VALUE = "female";
const ALL_VALUE = "all";

function setGenderCookie(selected) {
	if (selected == MALE_VALUE || selected == FEMALE_VALUE) {
		document.cookie = GENDER_COOKIE_NAME + "=" + selected + "; Path=/";
	} else {
		document.cookie = GENDER_COOKIE_NAME + "=; Path=/; Expires=Thu, 01 Jan 1970 00:00:00 GMT";
	}
}

function getGenderFromCookie() {
	let rawValue = document.cookie.split(";")
		.find((item) => item.trim().startsWith(GENDER_COOKIE_NAME + "="));
	if (rawValue) {
		rawValue = rawValue.split("=")[1];
	}
	if (rawValue == MALE_VALUE || rawValue == FEMALE_VALUE) {
		return rawValue;
	} else {
		return ALL_VALUE;
	}
}

function setGender(gender) {
	if (gender == MALE_VALUE || gender == FEMALE_VALUE) {
		document.body.dataset.onlyGender = gender;
	} else {
		delete document.body.dataset.onlyGender;
	}
}

document.addEventListener("DOMContentLoaded", () => {
	const cookieValue = getGenderFromCookie();
	document.querySelector("header .genders input[name='gender'][value='" + cookieValue + "']").checked = true;
	setGender(cookieValue);

	document.querySelectorAll("header .genders input[name='gender']").forEach(input => {
		input.addEventListener("change", () => {
			setGender(input.value);
			setGenderCookie(input.value);
		});
	});
});
