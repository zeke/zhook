function prepareSearchFormLabels() {
  var c = "#999999"
  $("#name_temp").inputLabel("Organization name",{color:c})
  $("#city_temp").inputLabel("City",{color:c})
  $("#county_temp").inputLabel("County",{color:c})
  $("#state_temp").inputLabel("State (2 letters)",{color:c})
  $("#zip_temp").inputLabel("Zip (5 digits)",{color:c});
}

// Remove blank or defaulted fields from the form before submitting it
function submitToRealSearchForm(temp_form) {

	// Copy all filled-in values over to the invisible form.
	var fields = new Array("name", "zip", "city", "county", "state")
  var labels = new Array("Organization name", "Zip (5 digits)", "City", "County", "State (2 letters)")
  
  for (var i=0; i<fields.length; i++) {
		var temp_field = $("#" + fields[i] + "_temp")
    var real_field = $("#" + fields[i])
    if (temp_field.val() == labels[i] || temp_field.val() == "") { 
			real_field.remove();
			temp_field.val("");
		} else {
			real_field.val(temp_field.val())
		}
  }

	// Treat metadata a little differently, because it's a radio button
	var m = $("#metadata")
	m.val(getCheckedValue(temp_form.metadata_temp))
	if (m.val() == "") { m.remove() }
	
	// If county is entered, state is required. no zip or city allowed.
	var zip = $('#zip_temp')
	var city = $('#city_temp')
	var county = $('#county_temp')
	var state = $('#state_temp')
	if (county.val() != "" && state.val().length != 2) {
		alert("When searching by county, you must enter the 2-letter state with it.")
		state.focus()
		prepareSearchFormLabels()
		return false
	}

	if (county.val() != "" && (city.val() != "" || zip.val() != "")) {
		alert("When searching by county, you cannot enter zip or city.")
		zip.focus()
		prepareSearchFormLabels()
		return false
	}
	
	// Submit the invisible form
  $("#real_search").submit()

	// This form never gets submitted.
	// It's just used as a vessel for the entered values.
  return false
}

function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}
