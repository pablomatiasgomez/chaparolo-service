var DataTable = function(_options) {
	var options = {
		url: "",
		containerSelector: "",
		tableItemTemplateSelector: "#table-item-template",
		pageSize: 10,
		ajaxHelper: null,
		objectMapper: null
	};
	$.extend(options, _options);

	if (!options.ajaxHelper) return;
	var ajax = options.ajaxHelper;

	if (!options.objectMapper) return;
	var objectMapper = options.objectMapper;

	var $container = $(options.containerSelector);

	if (!options.url) return;
	if (!$container.length) return;
	if (!$(options.tableItemTemplateSelector).length) return;

	var $table = $container.find("#list");
	var $pagination = $container.find("ul.pagination");

	if (!$table.length) return;
	if (!$pagination.length) return;

	// --------------------------------------------

	var tableItemTemplate = Handlebars.compile($(options.tableItemTemplateSelector).html());
	var offset = 0;
	var cantPages = 0;

	var fetchData = function() {
		var url = options.url + "?offset=" + offset + "&limit=" + options.pageSize;
		ajax.GET(url, function(data) {
			if (data.status == 200) {
				data = objectMapper.parseToCamelCase(data.responseText);
				loadTable(data);
			}
		});
	};

	var getPageButtons = function() {
		return $pagination.find("li.page-button");
	};

	var getNextButton = function() {
		return $pagination.find("li.pager-button:last");
	};

	var getCurrentPage = function() {
		return ((offset / options.pageSize) + 1);
	};

	var loadTable = function(data) {
		$table.find("tbody").html("");

		var tableItem;
		$.each(data.items, function() {
			tableItem = tableItemTemplate(this);
			$table.find("tbody").append(tableItem);
		});

		getPageButtons().remove();

		cantPages = Math.ceil(data.paging.total / data.paging.limit);

		for (var i = 1; i <= cantPages; i++) {
			var isCurrentPage = (getCurrentPage() == i);
			getNextButton().before("<li class='page-button " + (isCurrentPage ? "active" : "") + "' data-page='" + i + "'><a>" + i + "</a></li>");
		}
	};

	var bindEvents = function() {
		$pagination.on("click", "li.page-button:not(.active)", function() {
			var page = $(this).attr("data-page");
			offset = (page - 1) * options.pageSize;
			fetchData();
		});

		/*
		// Last Page
		$pagination.on("click", "li.pager-button:first", function() {
			offset = 0;
			fetchData();
		});
	
		// First page
		$pagination.on("click", "li.pager-button:last", function() {
			offset = (cantPages - 1) * options.pageSize;
			fetchData();
		});
		*/
		
		$pagination.on("click", "li.pager-button:first", function() {
			if (getCurrentPage() > 1) {
				offset = ((getCurrentPage() - 1) - 1) * options.pageSize;
				fetchData();
			}
		});

		$pagination.on("click", "li.pager-button:last", function() {
			if (getCurrentPage() < cantPages) {
				offset = ((getCurrentPage() + 1) - 1) * options.pageSize;
				fetchData();
			}
		});
	};

	fetchData();
	bindEvents();


	// Public methods:
	return {
		refreshPage: fetchData
	};
};