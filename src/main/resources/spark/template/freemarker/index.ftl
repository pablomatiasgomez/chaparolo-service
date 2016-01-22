<#import "main.ftl" as main>
<#compress>

<@main.page>
	<@main.panel title="Welcome to Campaigns Backoffice">
		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<a href="${basePath}/campaigns" class="btn btn-default btn-lg btn-block">
					<span class="glyphicon glyphicon-file" style="font-size: 50px"></span>
					<div>Manage Campaigns</div>
				</a>
			</div>
			<div class="col-sm-4"></div>
		</div>
	</@main.panel>
</@main.page>

</#compress>