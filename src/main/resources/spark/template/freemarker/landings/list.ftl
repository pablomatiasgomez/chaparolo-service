<#import "../main.ftl" as main>
<#compress>

<#assign js>
	<script>
		(function() {
			var ajax = new AjaxHelper();
			var objectMapper = new ObjectMapper();

			var dataTable = new DataTable({
				url: "${basePath}/campaigns/${campaignId}/landings/list",
				containerSelector: "#list-container",
				ajaxHelper: ajax,
				objectMapper: objectMapper
			});
		})();
	</script>
</#assign>

<@main.page js=js back="${basePath}/campaigns/${campaignId}/edit">

	<#if saved?? && saved>
		<div class="alert alert-success" role="alert">
			<strong><@main.message "campaigns.common.done" /></strong>
			<span class="detail"><@main.message "campaigns.common.saved" /></span>
		</div>
	</#if>

	<@main.panel title="Landings of <b>${campaignId}</b>">
		<div id="list-container">
			<a href="${basePath}/campaigns/${campaignId}/landings/new" type="button" class="btn btn-primary">
				<span class="glyphicon glyphicon-plus" style="margin-right: 5px;"></span><@main.message "campaigns.common.add" />
			</a>

			<table id="list" class="table table-striped">
				<thead>
					<tr>
						<th>ID</th>
						<th class="col-sm-2"><@main.message "campaigns.common.countries" /></th>
						<th class="col-sm-2"><@main.message "campaigns.common.products" /></th>
						<th><@main.message "campaigns.edit.fields.active" /></th>
						<th colspan="1"></th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>

			<nav>
				<ul class="pagination">
					<li class="pager-button"><a><span>&laquo;</span></a></li>
					<#--
					<li class="page-button active"><a>1</a></li>
					<li class="page-button"><a>2</a></li>
					-->
					<li class="pager-button"><a><span>&raquo;</span></a></li>
				</ul>
			</nav>
		</div>

		<script id="table-item-template" type="text/x-handlebars-template">
			<tr>
				<td>{{id}}</td>
				<td>
					{{#each countries}}
						<span class="label label-primary">{{this}}</span>
					{{/each}}
				</td>
				<td>
					{{#each products}}
						<span class="label label-info">{{this}}</span>
					{{/each}}
				</td>
				<td class="{{#if active}}success{{else}}danger{{/if}}">
					{{#if active}}
						YES
					{{else}}
						NO
					{{/if}}
				</td>
				<td>
					<a title="Edit" href="${basePath}/campaigns/${campaignId}/landings/{{id}}/edit">
						<span class="glyphicon glyphicon-pencil">
					</a>
				</td>
			</tr>
		</script>
	</@main.panel>
</@main.page>

</#compress>
