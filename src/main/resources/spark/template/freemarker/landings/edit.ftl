<#import "../main.ftl" as main>
<#compress>

<#assign REPLACE_NUMBER = 99999999 />
<#assign js>
	<script>
		Array.prototype.clean = function(deleteValue) {
			for (var i = 0; i < this.length; i++) {
				if (this[i] == deleteValue) {
					this.splice(i, 1);
					i--;
				}
			}
			return this;
		};

		(function() {
			
			var ajax = new AjaxHelper();
			var utils = new Utils();
			var objectMapper = new ObjectMapper();
			$(".color-picker").colorpicker();

			var countrySelector = utils.setCountrySelector();

			// Hotels info
			var $hotelsInfo = $(".hotels-info");

			$hotelsInfo.on("click", ".remove-hotel-info", function() {
				$(this).closest(".hotel-info").fadeOut(function() {
					$(this).remove();
				});
			});

			var hotelInfoTemplate = Handlebars.compile($("#hotel-info-template").html());
			$(".add-hotel-info").on("click", function() {
				var lastIndex = parseInt($hotelsInfo.find(".hotel-info:last").attr("data-index"));
				if (isNaN(lastIndex)) lastIndex = -1;

				var $hotelInfoItem = hotelInfoTemplate().replace(/${REPLACE_NUMBER?c}/g, lastIndex + 1);
				$hotelsInfo.append($hotelInfoItem);
			});

			// Save form:
			var $form = $("form.component-form");
			$form.on("submit", function() {
				var showError = function(message) {
					var $alert = $(".alert-danger.save-error");
					$alert.find(".detail").text(message);
					$alert.slideDown();
					$("html, body").animate({
						scrollTop: $alert.offset().top - 50
					}, 400);
				};

				var data = utils.serializeForm($form);
				data.countries = countrySelector.getSelectedCountries();
				data.products = $("#products-field input:checked").map(function() { return this.value }).toArray();
				data.active = !!$("#active-field input:checked").length;
				data.countdownEnabled = !!$("#countdownEnabled-field input:checked").length;
				if (data.hotels) {
					data.hotels.clean(undefined);
					data.hotels.forEach(function(hotel, i) {
						hotel.active = !!$form.find("#hotel-" + i + " input[type='checkbox']:checked").length;
						hotel.checkIn += ":00Z";
						hotel.checkOut += ":00Z";
					});
				}
				data = objectMapper.parseToUnderScore(data);

				ajax.POST("${basePath}/campaigns/${campaignId}/landings", data, function(data) {
					if (data.status == 200) {
						window.location.href = "${basePath}/campaigns/${campaignId}/landings?saved=true";
					} else {
						showError(data.responseText);
					}
				});

				return false;
			});
		})();
	</script>
	<@main.pictureSelectorModalJsScript />
</#assign>

<#if component??>
	<#assign title><@main.message "campaigns.common.editing" /> <@main.message "campaigns.landing" />: ${component.id!}</#assign>
<#else>
	<#assign title><@main.message "campaigns.common.new" /> <@main.message "campaigns.landing" /></#assign>
</#if>

<@main.page js=js back="${basePath}/campaigns/${campaignId}/landings">
	
	<@main.errorMessage />

	<@main.panel title=title>
		<div class="row">
			<div class="col-sm-12">
				<form class="component-form form-horizontal">
					<#if component??>
						<#assign readonly = true>
						<input type="hidden" value="${component.id!}" name="id" />
					<#else>
						<#assign readonly = false>
					</#if>

					<#assign label><@main.message "campaigns.edit.fields.active" /></#assign>
					<@main.booleanField label=label field=(component.active)! fieldStr="active" />

					<@main.productsSelector itemEditing=component />

					<@main.countriesSelector itemEditing=component />
					<#assign label><@main.message "campaigns.edit.fields.url" /></#assign>
					<@main.localizedField label=label field=(component.url)! fieldStr="url" />

					<#assign label><@main.message "campaigns.edit.fields.desktopImage" /></#assign>
					<@main.imageSelectorLocalizedField label=label field=(component.desktopImage)! fieldStr="desktopImage" />

					<#assign label><@main.message "campaigns.edit.fields.mobileImage" /></#assign>
					<@main.imageSelectorLocalizedField label=label field=(component.mobileImage)! fieldStr="mobileImage" />

					<#assign label><@main.message "campaigns.edit.fields.headerStickyImage" /></#assign>
					<@main.imageSelectorLocalizedField label=label field=(component.headerStickyImage)! fieldStr="headerStickyImage" />

					<#assign label><@main.message "campaigns.edit.fields.title" /></#assign>
					<@main.colouredLocalizedField label=label field=(component.title)! fieldStr="title" />

					<#assign label><@main.message "campaigns.edit.fields.discountValue" /></#assign>
					<@main.horizontalField label=label name="discountValue" value="${(component.discountValue)!}" type="number"  />

					<#assign label><@main.message "campaigns.edit.fields.discountColor" /></#assign>
					<@main.horizontalColorPickerField label=label name="discountColor" value="${(component.discountColor)!}" />

					<#assign label><@main.message "campaigns.edit.fields.drop" /></#assign>
					<@main.colouredLocalizedField label=label field=(component.drop)! fieldStr="drop" />

					<#assign label><@main.message "campaigns.edit.fields.countdownEnabled" /></#assign>
					<@main.booleanField label=label field=(component.countdownEnabled)! fieldStr="countdownEnabled" />

					<#assign label><@main.message "campaigns.edit.fields.countdown" /></#assign>
					<@main.colouredLocalizedField label=label field=(component.countdown)! fieldStr="countdown" />

					<#assign label><@main.message "campaigns.edit.fields.bgColor" /></#assign>
					<@main.horizontalColorPickerField label=label name="backgroundColor" value="${(component.backgroundColor)!}" />

					<#assign label><@main.message "campaigns.edit.fields.numbersColor" /></#assign>
					<@main.horizontalColorPickerField label=label name="numbersColor" value="${(component.numbersColor)!}" />

					<#assign label><@main.message "campaigns.edit.fields.numbersBgColor" /></#assign>
					<@main.horizontalColorPickerField label=label name="numbersBackgroundColor" value="${(component.numbersBackgroundColor)!}" />

					<#assign label><@main.message "campaigns.edit.fields.daysTextColor" /></#assign>
					<@main.horizontalColorPickerField label=label name="daysTextColor" value="${(component.daysTextColor)!}" />

					<#assign label><@main.message "campaigns.edit.fields.legalText" /></#assign>
					<@main.localizedField label=label field=(component.legalText)! fieldStr="legalText" />

					<#assign label><@main.message "campaigns.edit.fields.discountType" /></#assign>
					<@main.selectField label=label field=(component.discountType)! fieldStr="discountType" values=discountTypes />

					<#macro hotelForm i=0>
						<div class="panel panel-default hotel-info" data-index="${i?c}" >
							<div class="panel-heading" role="tab">
								<div class="row vertical-align">
									<div class="col-md-11">
										<h4 class="panel-title">
											<a role="button" data-toggle="collapse" href="#hotel-${i?c}">
												<@main.message "campaigns.edit.fields.hotel" /> #${i?c}
											</a>
										</h4>
									</div>
									<div class="col-md-1">
										<button type="button" class="btn btn-danger remove-hotel-info">
											<span class="glyphicon glyphicon-remove"></span>
										</button>
									</div>
								</div>
							</div>
							<div id="hotel-${i?c}" class="panel-collapse collapse" role="tabpanel">
								<div class="panel-body">
									<#assign label><@main.message "campaigns.edit.fields.hotelId" /></#assign>
									<@main.horizontalField label=label name="hotels[${i?c}][hotelId]" value="${(component.hotels[i].hotelId?c)!}" type="number" />

									<#assign label><@main.message "campaigns.edit.fields.active" /></#assign>
									<@main.booleanField label=label field=(component.hotels[i].active)! fieldStr="hotels[${i?c}][active]" />

									<#assign label><@main.message "campaigns.edit.fields.rooms" /></#assign>
									<@main.horizontalField label=label name="hotels[${i?c}][rooms]" value="${(component.hotels[i].rooms)!}" type="number" />

									<#assign label><@main.message "campaigns.edit.fields.travelWindow" /></#assign>
									<br />
									<div class="row">
										<label class="col-sm-2 control-label">${label}</label>
										<div class="col-sm-10 item-container">
											<#assign label><@main.message "campaigns.edit.fields.from" /></#assign>
											<@main.horizontalField label=label name="hotels[${i?c}][checkIn]" value="${(component.hotels[i].checkIn?replace(':00Z', ''))!}" type="datetime-local" />

											<#assign label><@main.message "campaigns.edit.fields.to" /></#assign>
											<@main.horizontalField label=label name="hotels[${i?c}][checkOut]" value="${(component.hotels[i].checkOut?replace(':00Z', ''))!}" type="datetime-local" />
										</div>
									</div>
									<br />
									

									<#assign label><@main.message "campaigns.edit.fields.minDays" /></#assign>
									<@main.horizontalField label=label name="hotels[${i?c}][minDays]" value="${(component.hotels[i].minDays)!}" type="number" />

									<#assign label><@main.message "campaigns.edit.fields.referencePrice" /></#assign>
									<@main.horizontalField label=label name="hotels[${i?c}][referencePrice]" value="${(component.hotels[i].referencePrice)!}" type="number" step="any" />

									<#assign label><@main.message "campaigns.edit.fields.maxRangeRaise" /></#assign>
									<@main.horizontalField label=label name="hotels[${i?c}][maxRangeRaise]" value="${(component.hotels[i].maxRangeRaise)!}" type="number" step="any" />

									<#assign label><@main.message "campaigns.edit.fields.paymentMethod" /></#assign>
									<@main.selectField label=label field=(component.hotels[i].paymentMethod)! fieldStr="hotels[${i?c}][paymentMethod]" values=paymentMethods />

									<#assign label><@main.message "campaigns.edit.fields.installments" /></#assign>
									<@main.horizontalField label=label name="hotels[${i?c}][installments]" value="${(component.hotels[i].installments)!}" type="number" />
								</div>
							</div>
						</div>
					</#macro>

					<#assign label><@main.message "campaigns.edit.fields.hotels" /></#assign>
					<br />
					<div class="row">
						<label class="col-sm-2 control-label">${label}</label>
						<div class="col-sm-10 item-container">
							<br />
							<div class="panel-group hotels-info" role="tablist">
								<#if (component.hotels)??>
									<#list component.hotels as hotel>
										<@hotelForm i=hotel_index />
									</#list>
								</#if>
							</div>
							<button type="button" class="btn btn-success add-hotel-info">
								<span class="glyphicon glyphicon-plus"></span>
							</button>
							<br />
							<br />
						</div>
					</div>
					<br />

					<br />
					<button type="submit" class="btn btn-success"><@main.message "campaigns.common.submit" /></button>
					<a href="${basePath}/campaigns/${campaignId}/landings" class=""><@main.message "campaigns.common.cancel" /></a>
				</form>
			</div>
		</div>

		<script id="hotel-info-template" type="text/x-handlebars-template">
			<@hotelForm i=REPLACE_NUMBER />
		</script>

		<@main.pictureSelectorModal />
	</@main.panel>

</@main.page>
</#compress>
