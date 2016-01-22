var AjaxHelper = function() {

	var HTTP_STATUS_OK = 200;
	var HTTP_STATUS_CREATED = 201;

	var HTTP_STATUS_BAD_REQUEST = 400;
	var HTTP_STATUS_UNAUTHORIZED = 401;
	var HTTP_STATUS_NOT_FOUND = 404;

	var HTTP_STATUS_INTERNAL_SERVER_ERROR = 500;

	// Makes an ajax to server
	var doAjax = function(url, type, data, callback) {
		$.ajax({
			headers: { 
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			contentType: "application/json",
			url: url + ((location.search.indexOf("d=1") != -1) ? ((url.indexOf("?") == -1) ? "?d=1" : "&d=1") : ""), // This is added to see the stacktrace on ajax calls when the url contains d=1
			type: type,
			dataType: 'json',
			data: (type != "GET") ? JSON.stringify(data) : data,
			complete: function(data) {
				if (data.status == HTTP_STATUS_UNAUTHORIZED) {
					redirectLogin();
				} else {
					if (callback) {
						callback(data);
					}
				}
			}
		});
	};

	var redirectLogin = function() {
		window.location.reload(true);
	};

	var doPost = function(url, data, callback) {
		doAjax(url, "POST", data, callback);
	};

	var doGet = function(url, callback) {
		doAjax(url, "GET", "", callback);
	};

	var doPatch = function(url, data, callback) {
		doAjax(url, "PATCH", data, callback);
	};

	var doDelete = function(url, data, callback) {
		doAjax(url, "DELETE", data, callback);
	};

	var doPut = function(url, data, callback) {
		doAjax(url, "PUT", data, callback);
	};

	var doHead = function(url, data, callback) {
		doAjax(url, "HEAD", data, callback);
	};

	return {
		POST: doPost,
		GET: doGet,
		PATCH: doPatch,
		DELETE: doDelete,
		PUT: doPut,
		HEAD: doHead,

		HTTP_STATUS_UNAUTHORIZED: HTTP_STATUS_UNAUTHORIZED,
		HTTP_STATUS_OK: HTTP_STATUS_OK,
		HTTP_STATUS_CREATED: HTTP_STATUS_CREATED,
		HTTP_STATUS_BAD_REQUEST: HTTP_STATUS_BAD_REQUEST,
		HTTP_STATUS_INTERNAL_SERVER_ERROR: HTTP_STATUS_INTERNAL_SERVER_ERROR,
		HTTP_STATUS_NOT_FOUND: HTTP_STATUS_NOT_FOUND
	};
};