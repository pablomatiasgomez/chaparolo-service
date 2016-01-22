var Utils = function() {

	var getSerliazedArray = function($form) {
		 // Find disabled inputs, and remove the "disabled" attribute
		var $disabled = $form.find(':input:disabled').removeAttr('disabled');
		// serialize the form
		var inputs = $form.serializeArray();
 		// re-disabled the set of inputs that you previously enabled
		$disabled.attr('disabled','disabled');

		return inputs;
	};
	
	var serializeForm = function($form) {
		var inputs = getSerliazedArray($form);
		var formObj = {};
		$.each(inputs, function() {
			if (this.value) {
				if (this.name.indexOf("[") != -1) { // is array or object, so I have to create the specific object
					var prop = formObj;
					var previousProp = null;
					this.name.replace(/\]/g, "").split("[").forEach(function(value) {
						if (previousProp) {
							if (!prop[previousProp]) { 
								// The prop does not exist, so I create it:

								if (isNaN(value)) {
									// Create object because next property is a string
									prop[previousProp] = {};
								} else {
									// Create array because next property is a number
									prop[previousProp] = [];
								}
							}
							prop = prop[previousProp];
						}
						previousProp = value;
					});
					prop[previousProp] = this.value;
				} else {
					formObj[this.name] = this.value;
				}
			}
		});
		return formObj;
	};

	// Returns the same date, that was expressed in GMT+0 (UTC), but with the current computer GMT, in order to be printed correctly
	var getDateFromUTC = function(date) {
		if (typeof date === "string") date = new Date(date);
		return new Date(date.getTime() + date.getTimezoneOffset() * 60000);
	};

	var setCountrySelector = function() {
		var $countriesToAdd = $("select.countries-to-add");
		var $countriesAdded = $("select.countries-added");
		
		var moveOptions = function($from, $to) {
			if ($from.val()) {
				var $option;
				$from.val().forEach(function(countryToMove) {
					$option = $from.find("option[value='" + countryToMove + "']");
					$option.prop("selected", false);
					$to.append($option);
				});
			}
		};

		$(".country-add").on("click", function() {
			moveOptions($countriesToAdd, $countriesAdded);
		});

		$(".country-remove").on("click", function() {
			moveOptions($countriesAdded, $countriesToAdd);
		});

		return {
			getSelectedCountries: function() {
				return $countriesAdded.find("option").map(function() { return this.value; }).toArray();
			}
		};
	};

	return {
		serializeForm: serializeForm,
		getDateFromUTC: getDateFromUTC,
		setCountrySelector: setCountrySelector
	};
};
