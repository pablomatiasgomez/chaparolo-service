<#import "../main.ftl" as main>
<#compress>

<#assign js>
	<script>
		(function() {
			
			var ajax = new AjaxHelper();
			var utils = new Utils();
			var objectMapper = new ObjectMapper();


			var countrySelector = utils.setCountrySelector();

			// Save form:
			var $form = $("form.campaign-form");
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
				data.dateFrom += ":00Z";
				data.dateTo += ":00Z";
				data.countries = countrySelector.getSelectedCountries();
				data.products = $("#products-field input:checked").map(function() { return this.value }).toArray();
				data.active = !!$("#active-field input:checked").length;
				data = objectMapper.parseToUnderScore(data);


				ajax.POST("${basePath}/campaigns?new=${(!campaign??)?string}", data, function(data) {
					if (data.status == 200) {
						window.location.href = "${basePath}/campaigns?saved=true";
					} else {
						showError(data.responseText);
					}
				});

				return false;
			});
		})();
	</script>
</#assign>

<#if campaign??>
	<#assign title><@main.message "campaigns.common.editing" /> <@main.message "campaigns.campaign" />: ${campaign.id!}</#assign>
<#else>
	<#assign title><@main.message "campaigns.common.new" /> <@main.message "campaigns.campaign" /></#assign>
</#if>

<@main.page js=js back="${basePath}/campaigns">

	<@main.errorMessage />

	<#if campaign??>
		<@main.panel title="Edit components">
			<div class="row">
				<div class="col-sm-1"></div>
				<div class="col-sm-2">
					<a href="${basePath}/campaigns/${campaign.id}/banners" class="btn btn-default btn-lg btn-block">
						<span class="glyphicon glyphicon-bold" style="font-size: 25px"></span>
						<h5>Banners (${(campaign.components.banner?size)!"0"})</h5>
					</a>
				</div>
				<div class="col-sm-2">
					<a href="${basePath}/campaigns/${campaign.id}/sbanners" class="btn btn-default btn-lg btn-block">
						<span class="glyphicon glyphicon-tasks" style="font-size: 25px"></span>
						<h5>Search Banners (${(campaign.components.searchBanner?size)!"0"})</h5>
					</a>
				</div>
				<div class="col-sm-2">
					<a href="${basePath}/campaigns/${campaign.id}/landings" class="btn btn-default btn-lg btn-block">
						<span class="glyphicon glyphicon-file" style="font-size: 25px"></span>
						<h5>Landings (${(campaign.components.landing?size)!"0"})</h5>
					</a>
				</div>
				<div class="col-sm-2">
					<a href="${basePath}/campaigns/${campaign.id}/sboxes" class="btn btn-default btn-lg btn-block">
						<span class="glyphicon glyphicon-search" style="font-size: 25px"></span>
						<h5>Search Boxes (${(campaign.components.searchBox?size)!"0"})</h5>
					</a>
				</div>
				<div class="col-sm-2">
					<a href="${basePath}/campaigns/${campaign.id}/newsletters" class="btn btn-default btn-lg btn-block">
						<span class="glyphicon glyphicon-inbox" style="font-size: 25px"></span>
						<h5>Newsletters (${(campaign.components.newsletter?size)!"0"})</h5>
					</a>
				</div>
				<div class="col-sm-1"></div>
			</div>
		</@main.panel>
	</#if>

	<@main.panel title=title>
		<div class="row">
			<div class="col-sm-12">
				<form class="campaign-form form-horizontal">
					<#if campaign??>
						<#assign readonly = true>
						<#-- input type="hidden" value="${campaign.id!}" name="id" / -->
					<#else>
						<#assign readonly = false>
					</#if>

					<#assign label><@main.message "campaigns.edit.fields.active" /></#assign>
					<@main.booleanField label=label field=(campaign.active)! fieldStr="active" />

					<#assign label><@main.message "campaigns.edit.fields.name" /></#assign>
					<@main.horizontalField label=label name="id" value="${(campaign.id)!}" readonly=readonly  />

					<@main.productsSelector itemEditing=campaign />

					<@main.countriesSelector itemEditing=campaign />

					<#assign label><@main.message "campaigns.edit.fields.from" /></#assign>
					<@main.horizontalField label=label name="dateFrom" value="${(campaign.dateFrom?replace(':00Z', ''))!}" type="datetime-local"  />

					<#assign label><@main.message "campaigns.edit.fields.to" /></#assign>
					<@main.horizontalField label=label name="dateTo" value="${(campaign.dateTo?replace(':00Z', ''))!}" type="datetime-local"  />

					<#assign label><@main.message "campaigns.edit.fields.descriptions" /></#assign>
					<@main.localizedField label=label field=(campaign.descriptions)! fieldStr="descriptions" />

					<br />
					<button type="submit" class="btn btn-success"><@main.message "campaigns.common.submit" /></button>
					<a href="${basePath}/campaigns" class=""><@main.message "campaigns.common.cancel" /></a>
				</form>
			</div>
		</div>
	</@main.panel>

</@main.page>
</#compress>
