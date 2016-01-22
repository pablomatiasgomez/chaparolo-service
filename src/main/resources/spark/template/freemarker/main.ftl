<#ftl encoding="UTF-8" />
<#macro message code>${messagesHelper.getMessage(code, language)}</#macro>
<#macro messageArgs code args>${messagesHelper.getMessage(code, args, language)}</#macro>
<#compress>

<#macro panel title>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">${title}</h3>
		</div>
		<div class="panel-body">
			<#nested>
		</div>
	</div>
</#macro>

<#macro errorMessage>
	<div class="alert alert-danger save-error" role="alert" style="display: none;">
		<@message "campaigns.common.error" />
		<br />
		<br />
		<span class="detail"></span>
	</div>
</#macro>

<#macro page js="" back="">
	<!DOCTYPE html>
	<html lang="es">

	<head>
		<title><@message "campaigns.common.title" /></title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

		<link rel="shortcut icon" type="image/gif" href="${imgPath!}/favicon.gif">

		<link rel="stylesheet" type="text/css" href="${cssPath!}/bootstrap.min.css?v=${staticContentVersion?c}">
		<link rel="stylesheet" type="text/css" href="${cssPath!}/bootstrap-colorpicker.min.css?v=${staticContentVersion?c}">
		<link rel="stylesheet" type="text/css" href="${cssPath!}/main.css?v=${staticContentVersion?c}">
	</head>

	<body>
		<div class="container">
			<div class="page-header">
				<img src="${imgPath!}/despegar.gif" class="pull-right" />
				<h2><a href="${basePath}"><@message "campaigns.common.title" /></a></h2>
				<#--ul class="nav nav-pills">
					<li role="presentation" style="margin-top: 14px; margin-left: 20px;">
						<a href="${basePath}/campaigns">
							<span class="glyphicon glyphicon-file" style="margin-right: 5px;"></span>Campaigns
						</a>
					</li>
				</ul-->
			</div>
			<p class="pull-right">
				<span><@message "campaigns.common.welcome" />${loggedUser!}</span>
				<a href="${basePath}/logout"><@message "campaigns.common.logout" /></a>
			</p>

			<#if back?has_content>
				<a class="pull-left" href="${back}">&lt; <@message "campaigns.common.back" /></a>
			</#if>
			<br /><br />

			<#nested>
		</div>
		
		<#-- END OF PAGE -->

		<div class="modal message fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
						<h4 class="modal-title">Message</h4>
					</div>
					<div class="modal-body">
						<p>${modalMessage!}</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"><@message "campaigns.common.close" /></button>
					</div>
				</div>
			</div>
		</div>


		<script src="${jsPath!}/jquery-1.11.2.min.js?v=${staticContentVersion?c}"></script>
		<script src="${jsPath!}/handlebars-1.0.0-rc.3.min.js?v=${staticContentVersion?c}"></script>
		<script src="${jsPath!}/bootstrap.min.js?v=${staticContentVersion?c}"></script>
		<script src="${jsPath!}/bootstrap-colorpicker.min.js?v=${staticContentVersion?c}"></script>
		<script src="${jsPath!}/Utils.js?v=${staticContentVersion?c}"></script>
		<script src="${jsPath!}/ObjectMapper.js?v=${staticContentVersion?c}"></script>
		<script src="${jsPath!}/AjaxHelper.js?v=${staticContentVersion?c}"></script>
		<script src="${jsPath!}/DataTable.js?v=${staticContentVersion?c}"></script>

		<script>
			Handlebars.registerHelper('getLocalizedName', function(object) {
				if (object) {
					return object['${language?upper_case}'] || object['${language?lower_case}'];
				}
			});
		</script>

		<script>
			(function() {
				var ajax = new AjaxHelper();
				setInterval(function() {
					ajax.HEAD("${basePath}/session");
				}, 60 * 1000); // Every 1 min
			})();
		</script>

		<#if modalMessage??>
			<script>
				$(".modal.message").modal("show");
			</script>
		</#if>

		${js}
	</body>
	</html>
</#macro>


<#macro horizontalField label name value="" type="text" readonly=false required=true step="">
	<div class="form-group" id="${name}-field">
		<label for="${name}" class="col-sm-2 control-label">${label}</label>
		<div class="col-sm-10">
			<input class="form-control" type="${type}" id="${name}" name="${name}" value="${value}" <#if readonly>readonly disabled</#if> <#if required>required</#if> step="${step}"/>
		</div>
	</div>
</#macro>

<#macro horizontalColorPickerField label name value="" readonly=false required=true>
	<div class="form-group" id="${name}-field">
		<label for="${name}" class="col-sm-2 control-label">${label}</label>
		<div class="col-sm-10">
			<div class="color-picker input-group">
				<input class="form-control" type="text" id="${name}" name="${name}" value="${value}" <#if readonly>readonly disabled</#if> <#if required>required</#if> />
				<span class="input-group-addon"><i></i></span>
			</div>
		</div>
	</div>
</#macro>

<#macro imageSelectorField label name value="" readonly=false required=true>
	<div class="form-group" id="${name}-field">
		<label for="${name}" class="col-sm-2 control-label">${label}</label>
		<div class="col-sm-10">
			<div class="input-group">
				<input class="form-control picture-key" type="text" id="${name}" name="${name}" value="${value}" <#if readonly>readonly disabled</#if> <#if required>required</#if> />
				<span class="input-group-addon"><span class="glyphicon glyphicon-cloud-upload upload-photo" data-toggle="modal" data-target="#image-selector"></span></span>
			</div>
		</div>
	</div>
</#macro>

<#macro field label name value="" type="text" info="" readonly=false>
	<div class="form-group" id="${name}-field">
		<label for="${name}" class="control-label">${label}</label>
		<input class="form-control" type="${type}" id="${name}" name="${name}" value="${value}" <#if readonly>readonly disabled</#if> required />
		<p class="help-block">${info}</p>
	</div>
</#macro>

<#macro textarea label name value="" info="" readonly=false>
	<div class="form-group" id="${name}-field">
		<label for="${name}">${label}</label>
		<textarea rows="10" class="form-control" id="${name}" name="${name}" <#if readonly>readonly disabled</#if> required>${value}</textarea>
		<p class="help-block">${info}</p>
	</div>
</#macro>

<#macro countriesSelector itemEditing={}>
	<div class="form-group" id="countries-field">
		<label for="products" class="col-sm-2 control-label"><@message "campaigns.common.countries" /></label>
		<div class="checkbox col-sm-4">
			<select multiple class="form-control countries-to-add" style="min-height: 150px">
				<#assign alreadyAdded = "" />
				<#assign separatorAdded = false />
				<#list countries?sort_by(["descriptions", language?lower_case])?reverse?sort_by("isSite")?reverse as country>
					<#if !(campaignCountries?? && !campaignCountries?seq_contains(country.code))>
						<#if (itemEditing.countries)?? && itemEditing.countries?seq_contains(country.code)>
							<#assign alreadyAdded>
								${alreadyAdded}
								<option value="${country.code}">${country.descriptions[language?lower_case]}</option>
							</#assign>
						<#else>
							<#if !country.isSite && !separatorAdded>
								<option disabled="">──────────────────────────────────────────────────────────────────</option>
								<#assign separatorAdded = true />
							</#if>
							<option value="${country.code}">${country.descriptions[language?lower_case]}</option>
						</#if>
					</#if>
				</#list>
			</select>
		</div>
		<div class="checkbox col-sm-2">
			<a class="btn btn-default btn-lg btn-block country-add">
				<span class="glyphicon glyphicon-arrow-right" style="font-size: 20px"></span>
			</a>
			<a class="btn btn-default btn-lg btn-block country-remove">
				<span class="glyphicon glyphicon-arrow-left" style="font-size: 20px"></span>
			</a>
		</div>
		<div class="checkbox col-sm-4">
			<select multiple class="form-control countries-added" style="min-height: 150px">
				${alreadyAdded}
			</select>
		</div>
	</div>
</#macro>

<#macro productsSelector itemEditing={}>
	<div class="form-group" id="products-field">
		<label for="products" class="col-sm-2 control-label"><@message "campaigns.common.products" /></label>
		<div class="checkbox col-sm-10">
			<#list products as product>
				<#if !(campaignProducts?? && !campaignProducts?seq_contains(product.id))>
					<#assign checked><#if (itemEditing.products)?? && itemEditing.products?seq_contains(product.id)>checked</#if></#assign>
					<label>
						<input type="checkbox" value="${product.id}" ${checked} />${product.description}
					</label>
					<br />
				</#if>
			</#list>
		</div>
	</div>
</#macro>

<#macro booleanField label field fieldStr="active" >
	<div class="form-group" id="${fieldStr}-field">
		<label for="active" class="col-sm-2 control-label">${label}</label>
		<div class="checkbox col-sm-10">
			<label>
				<input type="checkbox" id="${fieldStr}" name="${fieldStr}" <#if (field)?? && field?has_content && field>checked</#if> />${label}
			</label>
		</div>
	</div>
</#macro>

<#macro selectField label field fieldStr values>
	<div class="form-group" id="${fieldStr}-field">
		<label for="${fieldStr}" class="col-sm-2 control-label">${label}</label>
		<div class="col-sm-10">
			<select class="form-control" id="${fieldStr}" name="${fieldStr}">
				<#list values as value>
					<option value="${value}" <#if (field)?? && field == value>selected</#if>>${value}</option>
				</#list>
			</select>
		</div>
	</div>
</#macro>

<#macro localizedField label field fieldStr="descriptions">
	<br />
	<div class="row">
		<label class="col-sm-2 control-label">${label}</label>
		<div class="col-sm-10 item-container">
			<@main.horizontalField label="ES" value="${(field['es'])!}" name="${fieldStr}[es]" required=false />
			<@main.horizontalField label="EN" value="${(field['en'])!}" name="${fieldStr}[en]" required=false />
			<@main.horizontalField label="PT" value="${(field['pt'])!}" name="${fieldStr}[pt]" required=false />
		</div>
	</div>
	<br />
</#macro>

<#macro colouredLocalizedField label field fieldStr="descriptions" required=true>
	<br />
	<div class="row">
		<label class="col-sm-2 control-label">${label}</label>
		<div class="col-sm-10 item-container">
			<@main.horizontalField label="ES" value="${(field.values['es'])!}" name="${fieldStr}[values][es]" required=required />
			<@main.horizontalField label="EN" value="${(field.values['en'])!}" name="${fieldStr}[values][en]" required=required />
			<@main.horizontalField label="PT" value="${(field.values['pt'])!}" name="${fieldStr}[values][pt]" required=required />
			<@main.horizontalColorPickerField label="Color" value="${(field.color)!}" name="${fieldStr}[color]" required=required />
		</div>
	</div>
	<br />
</#macro>

<#macro imageSelectorLocalizedField label field fieldStr="pictures">
	<br />
	<div class="row">
		<label class="col-sm-2 control-label">${label}</label>
		<div class="col-sm-10 item-container">
			<@main.imageSelectorField label="ES" value="${(field['es'])!}" name="${fieldStr}[es]" required=false />
			<@main.imageSelectorField label="EN" value="${(field['en'])!}" name="${fieldStr}[en]" required=false />
			<@main.imageSelectorField label="PT" value="${(field['pt'])!}" name="${fieldStr}[pt]" required=false />
		</div>
	</div>
	<br />
</#macro>

<#macro pictureSelectorModal accept="">
	<div class="modal fade" id="image-selector" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel"><@message "campaigns.common.imageSelectorModal.title" /></h4>
				</div>
				<div class="modal-body">
					<div class="row images-preview">
						<script id="image-preview-template" type="text/x-handlebars-template">
							<div class="col-sm-3">
								<a class="thumbnail image-select" data-media-key="{{mediaKey}}">
									<img src="${imagesEndpoint}{{mediaKey}}" />
								</a>
							</div>
						</script>
					</div>

					<div class="progress" style="display: none;">
						<div class="progress-bar" role="progressbar"></div>
					</div>
					<form action="${basePath}/pictures" enctype="multipart/form-data" method="post" class="picture-upload-form">
						<label><@message "campaigns.common.imageSelectorModal.upload" /></label>
						<input type="file" name="image" class="picture-upload-input" multiple <#if accept?has_content>accept="${accept}"</#if>>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><@message "campaigns.common.close" /></button>
				</div>
			</div>
		</div>
	</div>
</#macro>

<#macro pictureSelectorModalJsScript>
	<script src="${jsPath!}/jquery.form.min.js?v=${staticContentVersion?c}"></script>
	<script>
		(function() {
			var $form = $("form.component-form");
			var objectMapper = new ObjectMapper();

			// Popover for image preview on form
			var popover = $form.find("input.picture-key").popover({
				trigger: "hover",
				html: true,
				placement: "top",
				content: "."
			}).on('show.bs.popover', function() {
				var mediaKey = $(this).val();
				if (mediaKey) {
					var url = "${imagesEndpoint}" + mediaKey;
					var html ="<img src='" + url + "' style='width: 100%;'/>";
					popover.attr('data-content', html);
				} else {
					popover.attr('data-content', "<@message 'campaigns.common.noImage' />");
				}
			});

			// Modal upload photo
			var $pictureInput = null;
			$form.on("click", ".upload-photo", function() {
				$pictureInput = $(this).closest(".input-group").find("input");
			});

			var $imageSelectorModal = $("#image-selector");
			$imageSelectorModal.on("click", ".image-select", function() {
				var mediaKey = $(this).attr("data-media-key");
				if ($pictureInput && $pictureInput.length) {
					$pictureInput.val(mediaKey);
				}
				$imageSelectorModal.modal("hide");
			});

			// Photo ajax uploader
			var imagePreviewTemplate = Handlebars.compile($("#image-preview-template").html());

			var $pictureUploadForm = $imageSelectorModal.find("form.picture-upload-form");
			var $pictureUploadInput = $pictureUploadForm.find("input.picture-upload-input");
			var $imagesPreview = $(".images-preview");

			$pictureUploadInput.on("change", function() {
				var files = $pictureUploadInput[0].files;
				if (!files || files.length == 0) return;
				$pictureUploadForm.submit();
			});

			var $progressBar = $imageSelectorModal.find(".progress");

			$pictureUploadForm.ajaxForm({
				complete: function(data) {
					$progressBar.hide();
					$pictureUploadInput.show();

					if (data.status == 200) {
						data = objectMapper.parseToCamelCase(data.responseText);
						data.forEach(function(mediaKey) {
							var $img = $(imagePreviewTemplate({mediaKey: mediaKey}))
							$imagesPreview.append($img);
						});
					}
				},
				beforeSend: function() {
					$progressBar.find(".progress-bar").width("0%");
					$progressBar.find(".progress-bar").text("0%");
					$pictureUploadInput.hide();
					$progressBar.show();
				},
				uploadProgress: function(event, position, total, percentComplete) {
					if (percentComplete == 100) percentComplete = 99;
					var percentVal = percentComplete + "%";
					$progressBar.find(".progress-bar").width(percentVal);
					$progressBar.find(".progress-bar").text(percentVal);
				}
			});
		})();
	</script>
</#macro>

</#compress>