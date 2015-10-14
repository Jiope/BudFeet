<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<title>Fit Me Motherfucker !</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<!-- JQuery -->
		<asset:javascript src="jquery-1.9.1.js"/>
		<asset:javascript src="jquery-ui.js"/>
		<asset:javascript src="dragdealer.js"/>
		
		<!-- Bootstrap -->		
		<asset:stylesheet src="bootstrap-theme.min.css"/>
		<asset:stylesheet src="bootstrap.min.css"/>
		<asset:javascript src="bootstrap.min.js"/>
		<!-- Custom CSS -->
		<asset:stylesheet src="main.css"/>
		
		<g:layoutHead/>
		
		<style type="text/css">
			#budfeetlog {
				color:black;
				font-size:11px;
				position:fixed;
				top:0px;right:0px;
				background-color:#e9e9e9;
				border:2px solid black;
				padding:3px;
			}
		</style>

	</head>
	<body>
		<div class="body container-fluid">
	
	      <div class="row header">
	        <div class="col-xs-12 col-sm-12 col-md-12">
	        </div>
	      </div>
	
	      <div id="topnavigation" class="row navigation">
            <div class="col-xs-12 col-sm-12 col-md-12">
              <div>
              	<g:link controller="login" action="index" class="btn btn-default btn-circle">Login</g:link>
              	<g:link controller="login" action="signup" class="btn btn-default btn-circle">Sign Up</g:link>
              	<g:link controller="navigation" action="calendar" class="btn btn-default btn-circle">Calendar</g:link>
              	<g:link controller="navigation" action="settings" class="btn btn-default btn-circle">Settings</g:link>
              	<g:link controller="login" action="account" class="btn btn-default btn-circle">Account</g:link>
              	<g:link controller="login" action="logout" class="btn btn-default btn-circle">Logout</g:link>
              </div>
            </div>
          </div>
	          
	          <div class="row">
	          	<div class="col-xs-2 col-sm-2 col-md-2" style="padding:10px;border-right:1px solid #c1c1c1;border-bottom:1px solid #c1c1c1;height:750px;">
					
					<div id="overview" class="overview">
						<div style="color:black;opacity:1;">					
							<table id="tableOverview" class="dataLoupe">
							<caption style="text-align:center;color:black;font-size:1.2em;">Overview</caption>	
							  <tr>
							    <th>Category</th>
							    <th>Total</th>		
							  </tr>
							  <g:each in="${almanac.categories}" var="categorie" status="${index}" >
								  <tr>
								    <td id="${categorie.libelle}" style="color:${categorie.color}">${categorie.libelle}</td>
								    <td id="${categorie.libelle}_amount" style="color:${categorie.color}">${categorie.amount}</td>
								  </tr>
							  </g:each>
							</table>
							<div type="button" onclick="togglePopupCategorie();" class="glyphicon glyphicon-plus" style="cursor:pointer;font-size:18px;"></div>	
					<%-- Add categorie --%>
							<div id="popupCategorie" class="popupCategorie" style="display:none;">
								<div style="text-align:center;border-bottom:1px solid black;margin-bottom:15px;">Create a category</div>		
								<div id="dataCategorie" style="display:block;">
									<table style="width:100%;margin-bottom:10px;">
									<tr>
										<td style="width:40%;">
											<div>Libelle </div>
										</td>	
										<td style="width:40%;">
											<input id="catLibelle" type="text" name="libelle" style="width:100%;" >
										</td>
									</tr>
									<tr id="trshortlibelle">
										<td style="width:40%;">
											<div id="shortlibelle" style="color:#d1d1d1">Short libelle </div>
										</td>	
										<td style="width:40%;">
											<input id="shortlibelleInput" id="catLibelle" type="text" name="libelle" style="width:100%;">
										</td>
									</tr>
									<tr>
										<td style="width:40%;">
											<div>Color  </div>
										</td>
										<td>
											<input id="catColor" type="text" name="color" style="width:100%;" >
										</td>
									</tr>
									</table>
									<input id="categorieSubmit" type="submit" class="btn btn-primary" onclick="saveCategorie();" onkeypress="this.onclick" value="Create">
								</div>
							</div>
						</div>
					</div>
					
					<div id="loupe" class="loupe">
						<div style="color:black;opacity:1;">
							<span id="date" style="font-size:1.2em;text-align:left;padding:5px;padding-left:20px;">../../....</span>
							<span id="total" style="font-size:1.2em;text-align:right;padding:5px;"></span>						
							<table class="dataLoupe">
							  <tr>
							    <th>Category</th>
							    <th>Amount</th>		
							  </tr>
							  <g:each in="${0..15}" var="index" >
								  <tr>
								    <td id="catLoup_${index}" style="visibility:hidden"></td>
								    <td id="monLoup_${index}" style="visibility:hidden"></td>
								  </tr>
							  </g:each>
							</table>
							
							
						</div>
					</div>
	          		
		        </div>
		        <section id="calendarWindow" class="col-xs-10 col-sm-10 col-md-10">
		          <g:layoutBody/>
		        </section>
		       </div>
	      
	      <div class="row footer">
	        <div class="col-xs-12 col-sm-12 col-md-12">
	        	WebApp by Jiope
	        </div>
	      </div>
	
	    </div>
	    
	    <div id="budfeetlog"></div>
	    
	    <script type="text/javascript">
			function togglePopupCategorie() {
				var display = $("#popupCategorie").css("display");
				if (display === "block")
					$("#popupCategorie").css("display", "none");
				else
					$("#popupCategorie").css("display", "");
			}

			

			$('#catLibelle').on('input', function() { 
			    if (this.value.length > 6) {
					$('#shortlibelleInput').removeAttr('disabled');
					$('#shortlibelle').css("color", "black");
				} else {
					$('#shortlibelleInput').attr('disabled', 'disabled');
					$('#shortlibelle').css("color", "#d1d1d1");
				}
			});
			$('#shortlibelleInput').attr('disabled', 'disabled');


			// Reset form attributes
			$('#shortlibelle').value='';
			$('#shortlibelleInput').value='';
			$('#catColor').value='';
	    </script>
	</body>
</html>
