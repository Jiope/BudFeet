<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<title>Calendar Page</title>
		<asset:stylesheet src="calendar.css"/>
		<asset:javascript src="sliding.js"/>
		<asset:javascript src="calendar.js"/>
		<meta name="layout" content="cal_layout">
		
		<%@ page import="cal.constantes.Constantes" %>
		
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	
	<script type="text/javascript">
		//handleSlidings();
	</script>
		
	</head>
	<body>
		<script type="application/javascript">		
			function showDetails(id, date) {
				// Effect on hover
				document.getElementById("day_" + id).setAttribute("class", "hover");
				document.getElementById("date").innerHTML = date;
				document.getElementById("total").innerHTML = document.getElementById("totalDay_" + id).textContent;
				// Set Loupe details
				
				//var allCat = document.querySelectorAll('*[id^="money_'+id+'"]');
				var allCat = document.querySelectorAll('*[id^="'+id+'_money"]');
				var allMon = document.querySelectorAll('*[id^="'+id+'_categorie"]');

				var c, m;
				for (var index = 0; index < allCat.length; index++) {

					c = document.getElementById("catLoup_" + index);
					c.innerHTML = allMon[index].textContent;
					c.setAttribute('style', "color:" + allCat[index].style.fill);
					c.style.visibility = 'visible';

					m = document.getElementById("monLoup_" + index);
					m.innerHTML = allCat[index].textContent;
					m.setAttribute('style', "color:" + allMon[index].style.fill);
					m.style.visibility = 'visible';
				}				
			}
			
			function hideDetails(id) {
				var cell = document.getElementById("day_" + id);
				cell.setAttribute("class", "box");

				
				document.getElementById("date").innerHTML = "../../....";
				document.getElementById("total").innerHTML = "";
				var allCat = document.querySelectorAll('*[id^="'+id+'_money"]');
				var allMon = document.querySelectorAll('*[id^="'+id+'_categorie"]');

				var c, m;
				for (var index = 0; index < allCat.length; index++) {

					c = document.getElementById("catLoup_" + index);
					c.innerHTML = "";
					c.style.visibility = 'hidden';

					m = document.getElementById("monLoup_" + index);
					m.innerHTML = "";
					m.style.visibility = 'hidden';
				}			
				
			}

			function openPopup(id, date){
				document.getElementById('popupbg').style="display:block";
				document.getElementById('popupCell').style="display:block";

				document.getElementById("entryTitre").innerHTML = date;

				$("#entrySubmit").attr('onclick', "saveEntry('" + id + "');");
			};
			
			function closePopup(){
				document.getElementById('popupbg').style="display:none";
				document.getElementById('popupCell').style="display:none";
			};

			function getSaveEntryParams() {
				var params = '';

				params += "categorie=" + document.getElementById("selectCategories").value + "&";
				params += "date=" + document.getElementById("entryTitre").innerHTML + "&";
				params += "amount=" + document.getElementById("entryAmount").value + "&";
				params += "infos=" + document.getElementById("entryInfos").value;
				return params;
			};

			function getSaveCategorieParams() {
				var params = '';

				params += "libelle=" + document.getElementById("catLibelle").value + "&";
				params += "shortlibelle=" + document.getElementById("shortlibelleInput").value + "&";
				params += "color=" + document.getElementById("catColor").value;
				return params;
			};

			function saveCategorie() {
				var xmlhttp;
				var params = getSaveCategorieParams();
				
				if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				} else {// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				//Send the proper header information along with the request
				xmlhttp.onreadystatechange=function(){
						if (xmlhttp.readyState==4 && xmlhttp.status==200) {
							displayCategorie(params, xmlhttp.responseText);
						}
					};
				xmlhttp.open("POST","http://localhost:8080/BudFeet/navigation/createCategorie?" + params,true);
				xmlhttp.send(params);
			};

			function displayCategorie(params, response) {
				//var col = document.getElementById('tableOverview');
				var col = $('#tableOverview > tbody');
				var param_tab = params.split('&');
				var libelle = param_tab[0].split('=');
				var color = param_tab[2].split('=');
				
				var cell = document.createElement("tr");
				var lib = document.createElement("td");
				lib.setAttribute('id', libelle[1]);
				lib.setAttribute('style', 'color:' + color[1]);
				lib.innerHTML = libelle[1];
				var amount = document.createElement("td");
				amount.setAttribute('id', libelle[1] + "_0");
				amount.setAttribute('style', 'color:' + color[1]);
				amount.innerHTML = "0.0";

				cell.appendChild(lib);
				cell.appendChild(amount);
				col.append(cell);

				var x = document.getElementById("selectCategories");
				var option = document.createElement("option");
				option.text = libelle[1];
				// id="categorieOption_4" value="clothes" style="color:red" onclick="updatePopupCell('red')"
				option.setAttribute('id', 'categorieOption_' + document.getElementById('selectCategories').length);
				option.setAttribute('value', libelle[1]);
				option.setAttribute('style', 'color:' + color[1]);
				option.setAttribute('onclick', 'updatePopupCell("' + color[1] + '")');
				x.add(option);

				var resp = document.getElementById("budfeetlog");
				var line = document.createElement("span");
				line.textContent = response;
				resp.appendChild(line);
				resp.appendChild(document.createElement('br'));

				// Close popup categorie
				$("#popupCategorie").css("display", "none");
				
			};

			function saveEntry(id) {
				var xmlhttp;
				var params = getSaveEntryParams();
				
				if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				} else {// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				//Send the proper header information along with the request
				xmlhttp.onreadystatechange=function(){
						if (xmlhttp.readyState==4 && xmlhttp.status==200) {
							displayEntry(id, xmlhttp.responseText);
						}
					};
				xmlhttp.open("POST","http://localhost:8080/BudFeet/navigation/createEntry?" + params,true);
				xmlhttp.send(params);
			};

			function displayEntry(id, response) {
				
				var categorieValue = document.getElementById("selectCategories").value;
				var amount = document.getElementById("entryAmount").value;
				var color  = document.getElementById(categorieValue).style.color;

				var cell = document.getElementById("day_" + id);
				var placement = document.getElementById("group_entries_" + id).children.length/2+1;
				
				var x = parseInt(cell.getAttributeNS(null, 'x')) + 10;
				var y = parseInt(cell.getAttributeNS(null, 'y')) + 20*placement + 20;
				var categorie = document.createElementNS('http://www.w3.org/2000/svg', 'text');
				categorie.setAttribute('id', id + '_categorie_' + placement);
				categorie.setAttribute('width', '70');
				categorie.setAttribute('x', x);
				categorie.setAttribute('y', y);
				categorie.textContent = categorieValue;

				var money = document.createElementNS('http://www.w3.org/2000/svg', 'text');
				money.setAttribute('id', id + '_money_' + placement);
				money.setAttribute('width', '55');
				money.setAttribute('x', x+140);
				money.setAttribute('y', y);
				money.setAttribute('text-anchor', 'end');
				money.textContent = amount + " €";

				var groupEntries = document.getElementById("group_entries_" + id);
				groupEntries.appendChild(categorie);
				groupEntries.appendChild(money);
				
				//document.getElementById("group_" + id).appendChild(groupEntries);
				categorie.setAttribute('style', "fill:" + color);
				money.setAttribute('style', "fill:" + color);
				if (placement > 3) {
					categorie.setAttribute('style', "visibility:hidden;fill:" + color);
					money.setAttribute('style', "visibility:hidden;fill:" + color);
				}

				var cal = document.getElementById(categorieValue + "_amount");
				cal.textContent = parseFloat(cal.textContent) + parseFloat(amount);

				var resp = document.getElementById("budfeetlog");
				var line = document.createElement("span");
				line.textContent = response;
				resp.appendChild(line);
				resp.appendChild(document.createElement('br'));

				updateAmount(id);
				closePopup();
			}

			function updateAmount(id) {
				var doc = document.getElementById("totalDay_" + id);

				var moneys = document.querySelectorAll('*[id^="money_'+id+'"]');
				var amount = 0;

				var value = 0;
				for (var index = 0; index < moneys.length; index++) {
					value = moneys[index].textContent;
					amount += parseFloat(value.substring(0,value.length-2));
				}

				doc.innerHTML = amount + "€";
				
			}
			
		</script>
		
		
		<div id="popupbg" class="popbg" style="display:none" onclick="closePopup();"></div>
		<div id="popupCell" class="fenetre" style="display:none;">
			<div id="entryTitre" style="text-align:center;border-bottom:1px solid black;margin-bottom:15px;"></div>
			<div style="border-bottom:1px solid black;margin-bottom:15px;text-align:center;padding-bottom:10px;">
				<label for="selectCategories">Select category : </label>
				<select id="selectCategories" style="color:black">
					<g:each in="${almanac.categories}" var="categorie" status="${index}">
						<g:if test="${index == 0}">
							<option selected id="categorieOption_${index}" onclick="updatePopupCell('${categorie.color}')" style="color:${categorie.color}" value="${categorie.libelle}">${categorie.libelle}</option>
						</g:if>
						<g:else>
							<option id="categorieOption_${index}" onclick="updatePopupCell('${categorie.color}')" style="color:${categorie.color}" value="${categorie.libelle}">${categorie.libelle}</option>
						</g:else>
					</g:each>
				</select>		
			</div>
			
			<script type="text/javascript">
				function updatePopupCell(color) {
					$('#selectCategories').css('color', color);
				}
			</script>
			
			<div id="data" style="display:block;">
				<table style="width:100%;margin-bottom:10px;">
				<tr>
					<td style="width:40%;">
						<div>Amount :</div>
					</td>	
					<td>
						<input id="entryAmount" type="text" />
					</td>
				</tr>
				<tr>
					<td style="width:40%;">
						<div>Infos  :</div>
					</td>
					<td>
						<input id="entryInfos" type="text" name="Infos" />
					</td>
				</tr>
				</table>
				<input id="entrySubmit" type="submit" class="btn btn-primary" value="Create"/>
			</div>
		</div>
		
	
		<div class="col-md-12" style="height:750px">
		
			<span id="leftarrow" onclick="move('left')" class="leftarrow glyphicon glyphicon-chevron-left animate"></span>
			<span id="rightarrow" onclick="move('right')" class="rightarrow glyphicon glyphicon-chevron-right animate"></span>
			<div style="height:100%" >
			<svg class="year dragdealer" id="cal" style="width:100%;height:100%;display:inline-block;">
				 
				<filter id = "i1" width = "150%" height = "150%">
					<feOffset result = "offOut" in = "SourceAlpha" dx = "8" dy = "10"/>
					<feGaussianBlur result = "blurOut" in = "offOut" stdDeviation = "3"/>
					<feBlend in = "SourceGraphic" in2 = "blurOut" mode = "normal"/>
				</filter>
				
				<g id="calendar" class="animate" transform="translate(0)">
					<g:set var="id" value="${0}" />					
					<g:each in="${almanac.listMonth}" var="month" status="${monthCount}">
						<g id="month_${month.year}_${month.monthInYear}" class="animate" transform="translate(0,0)">
							<text id="monthName_${month.year}_${month.monthInYear}" 
								  x="${(month.nameRight[0]+month.nameLeft[0])/2}" y="${Constantes.svgMY5}" 
								  text-anchor="middle" style="font-size:24px;">
								  ${month.monthName}
							</text>
						<g:each in="${month.days}" var="day" status="${dayCount}">
							<g:set var="id" value="${month.year}_${month.monthInYear}_${dayCount}" />
							
		<g id="group_${id}" class="cellGroup" transform="translate(0,0)" filter="url(#i1)"
			onmouseenter="showDetails('${id}', '${day.date}')" 
			onmouseleave="hideDetails('${id}')">
			<rect id="day_${id}" class="box" x="${day.posX}" y="${day.posY}" width="${day.width}" height="${day.height}"
				  rx="5" ry="5" onclick="openPopup('${id}', '${day.date}');"/>
			<text id="dayOfMonth_${id}" x="${day.posX+Constantes.svgMX1}" y="${day.posY+Constantes.svgMY1}" alignment-baseline="baseline">${day.dayOfMonth}</text>
			<g:if test="${day.totalAmount != 0}" >
				<text id="totalDay_${id}" x="${day.posX+Constantes.svgMX3}" y="${day.posY+Constantes.svgMY1}" text-anchor="end">${day.totalAmount}</text>
			</g:if>
			<g:else>
				<text id="totalDay_${id}" x="${day.posX+Constantes.svgMX3}" y="${day.posY+Constantes.svgMY1}" text-anchor="end"></text>
			</g:else>
			
			<path stroke="black" d="M${day.posX+Constantes.svgMX1} ${day.posY+Constantes.svgMY2} L${day.posX+day.width-Constantes.svgMX1} ${day.posY+Constantes.svgMY2}" />
			<g id="group_entries_${id}" class="entries">
			<g:each in="${day.entries}" var="entry" status="${entryCount}">
				<text id="${id}_categorie_${entryCount}" style="fill:${entry.color}" width="70" x="${day.posX+10}" y="${day.posY+20*(entryCount+1)+20}">${entry.categorie}</text>
				<text id="${id}_money_${entryCount}" style="fill:${entry.color}" width="55" x="${day.posX+150}" y="${day.posY+20*(entryCount+1)+20}" text-anchor="end">${entry.amount} €</text>
			</g:each>
			</g>
		</g>
							
						</g:each>
						
						
						
						</g>
					</g:each>
				</g>
			</svg>
			</div>
		</div>
		
		<span id="calendarPosition" style="display:none;">0</span>
	</body>
</html>

<%-- <g:each var="month" in="${[0..11]}">
					<g:each var="day" in="${[0..35]}">
					</g:each>
				</g:each>
<input type="submit" class="btn btn-default green box opacity50" width="${cell.length}" height="${cell.length}" x="${cell.posX}" y="${cell.posY}" rx="4" ry="4" />  --%>