var ObjectMapper = function() {
	// under_score to camelCase reviver
	var reviverUTC = function(k, v) {
		if (k) {
			var oldK = k;
			k = k.replace(/(_[a-z])/g, function(l) { return l.toUpperCase().replace('_',''); });
			if (oldK == k) return v;
			this[k] = v;
		} else {
			return v;
		} 
	};

	// camelCase to under_score reviver
	var reviverCTU = function(k, v) {
		if (k) {
			var oldK = k;
			k = k.replace(/([A-Z])/g, function(l) { return "_" + l.toLowerCase(); });
			if (oldK == k) return v;
			this[k] = v;
		} else {
			return v;
		} 
	};

	var parseToCamelCase = function(object) {
		if (object === "") return {};
		if (typeof object === "object") object = JSON.stringify(object);

		try {
			return JSON.parse(object, reviverUTC);
		} catch (error) {
			throw "Not valid JSON (" + error + "): \"" + object + "\"";
		}
	};

	var parseToUnderScore = function(object) {
		if (object === "") return {};
		if (typeof object === "object") object = JSON.stringify(object);

		try {
			return JSON.parse(object, reviverCTU);
		} catch (error) {
			throw "Not valid JSON (" + error + "): \"" + object + "\"";
		}
	};

	return {
		parseToCamelCase: parseToCamelCase,
		parseToUnderScore: parseToUnderScore
	};
};