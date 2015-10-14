function loadMonth(direction) {
	var xmlhttp;
	var params = getLoadMonthParams(direction);

	//showLoading();
	
	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	//Send the proper header information along with the request
	xmlhttp.onreadystatechange=function(){
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {
				displayMonth(direction, xmlhttp.responseText);
			}
		};
	xmlhttp.open("POST","http://localhost:8080/BudFeet/navigation/loadMonth?" + params,true);
	xmlhttp.send(params);
	
	$('#calendar').unbind('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend');
	$('#calendar :first-child').remove();
};

function handleReload() {
	var firstX = document.getElementById("calendar").firstElementChild.children[1].firstElementChild.getAttribute('x');
	var lastX = document.getElementById("calendar").lastElementChild.children[1].firstElementChild.getAttribute('x');
	var transform = document.getElementById("calendar").style.transform;
	alert('first :' + firstX);
	alert('last : ' + lastX);
	alert('transform : ' + transform);
	
	var offset = transform.match(/\d+/g);
	
	return true;
};

function moveCalendar(direction) {
	//var data = JSON.parse(response);
	
	var newPosition = 0;
	
	if (direction == "right")
		newPosition = "-2000";
	else newPosition = "2000"; 
	
	$('#calendar :first-child').css('opacity', '0');
	$('#calendar').bind('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function(){ loadMonth(direction);});
	
	//loadMonth(direction);
	//$('#calendar').bind('transitionend', function(){  });
	
	//$('#calendar :first-child').remove();
}

function move(direction) {
	//handleReload();
	disableMoveButtons();
	moveCalendar(direction);
	
//	var xmlhttp;
//	
//	var params = getLoadMonthParams(direction);
//	
//	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
//		xmlhttp=new XMLHttpRequest();
//	} else {// code for IE6, IE5
//		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
//	}
	//Send the proper header information along with the request
//	xmlhttp.onreadystatechange=function(){
//			if (xmlhttp.readyState==4 && xmlhttp.status==200) {
//				moveCalendar(direction, xmlhttp.responseText);
//			}
//		};
//	xmlhttp.open("POST","http://localhost:8080/BudFeet/navigation/getMonthOffset?" + params,true);
//	xmlhttp.send(params);	
};

function showLoading() {
	
	var animate1 = document.createElementNS('http://www.w3.org/2000/svg', 'animate');
	animate1.setAttribute('attributeName', 'stroke-dashoffset');
	animate1.setAttribute('dur', '3s');
	animate1.setAttribute('repeatCount', 'indefinite');
	animate1.setAttribute('from', '0');
	animate1.setAttribute('to', '502');
	
	var animate2 = document.createElementNS('http://www.w3.org/2000/svg', 'animate');
	animate2.setAttribute('attributeName', 'stroke-dasharray');
	animate2.setAttribute('dur', '3s');
	animate2.setAttribute('repeatCount', 'indefinite');
	animate2.setAttribute('values', '150.6 100.4;1 250;150.6 100.4');	
	
	var loadingIcon = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
	loadingIcon.setAttribute('id', 'loadingIcon');
	loadingIcon.setAttribute('cx', '430');
	loadingIcon.setAttribute('cy', '300');
	loadingIcon.setAttribute('r', '20');
	loadingIcon.setAttribute('stroke', '#2b84d8');
	loadingIcon.setAttribute('fill', 'none');
	loadingIcon.setAttribute('stroke-width', '6');
	loadingIcon.setAttribute('stroke-linecap', 'round');
	loadingIcon.appendChild(animate1);
	loadingIcon.appendChild(animate2);
	
	document.getElementById("cal").appendChild(loadingIcon);
	
};

function hideLoading() {
	var loadingIcon = document.getElementById("loadingIcon");
	loadingIcon.parentNode.removeChild(loadingIcon);
};

function getLoadMonthParams(direction) {

	var monthId;
	var x0;
	if (direction == "left") {
		//x0 = document.getElementById("calendar").firstElementChild.children[1].firstElementChild.getAttribute('x');
		monthId = document.getElementById("calendar").firstElementChild.getAttribute('id');
	}
	else {
		//x0 = document.getElementById("calendar").lastElementChild.children[1].firstElementChild.getAttribute('x');
		monthId = document.getElementById("calendar").lastElementChild.getAttribute('id');
	}
	var split = monthId.split('_');				
	var params = '';
	params += "monthInYear=" + split[2] + '&';
	params += "year=" + split[1] + '&';
	params += "direction=" + direction;
	//params += "x0=" + x0;
	
	return params;
};

function displayMonth(direction, response) {
	var data = JSON.parse(response);

	var month = document.createElementNS('http://www.w3.org/2000/svg', 'g');
	month.setAttribute('id', "month_" + data.year + "_" + data.monthInYear);
	month.setAttribute('class', 'animate');
	month.setAttribute('style', 'opacity:0');
	month.setAttribute('transform', 'translate(0,0)');

	var monthName = document.createElementNS('http://www.w3.org/2000/svg', 'text');
	monthName.setAttribute('id', 'monthName_' + data.year + '_' + data.monthInYear);
	monthName.setAttribute('x', (data.nameRight[0]+data.nameLeft[0])/2);
	monthName.setAttribute('y', 35); // Constantes.svgMY5
	monthName.setAttribute('text-anchor', 'middle');
	monthName.setAttribute('style', 'font-size:24px;');		
	monthName.textContent = data.monthName;

	month.appendChild(monthName);

	// 1st boucle vars
	var group;
	var day;
	var dayData;
	var dayOfMonth;
	var totalDay;
	var path;
	var groupEntries;
	// 2nd boucle vars
	var categorie;
	var money;
	var entryData;
	
	for (var index = 0; index < data.days.length; index++) {
		var id = data.year + "_" + data.monthInYear + "_" + index;
		dayData = data.days[index];
		group = document.createElementNS('http://www.w3.org/2000/svg', 'g');
		group.setAttribute('id', "group_" + id);
		group.setAttribute('class', 'cellGroup');
		group.setAttribute('transform', 'translate(0,0)');
		group.setAttribute('filter', 'url(#i1)');
		group.setAttribute('onmouseenter', "showDetails('" + id + "', '" + dayData.date + "', '" + data.monthOffset + "');");
		group.setAttribute('onmouseleave', "hideDetails('" + id + "');");
		
		day = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
		day.setAttribute('id', "day_" + id);
		day.setAttribute('class', 'box');
		day.setAttribute('x', dayData.posX);
		day.setAttribute('y', dayData.posY);
		day.setAttribute('width', 160);
		day.setAttribute('height', 90);
		day.setAttribute('rx', '5');
		day.setAttribute('ry', '5');
		day.setAttribute('onclick', "openPopup('" + id + "', '" + dayData.date + "');");
		
		dayOfMonth = document.createElementNS('http://www.w3.org/2000/svg', 'text');
		dayOfMonth.setAttribute('id', "dayOfMonth_" + id);
		dayOfMonth.setAttribute('x', parseInt(dayData.posX) + 10); //Constantes.svgMX1
		dayOfMonth.setAttribute('y', parseInt(dayData.posY) + 20); //Constantes.svgMY1
		dayOfMonth.setAttribute('alignment-baseline', 'baseline');
		dayOfMonth.textContent = dayData.dayOfMonth;

		totalDay = document.createElementNS('http://www.w3.org/2000/svg', 'text');
		totalDay.setAttribute('id', "totalDay_" + id);
		totalDay.setAttribute('x', parseInt(dayData.posX) + 155); //Constantes.svgMX3
		totalDay.setAttribute('y', parseInt(dayData.posY) + 20); //Constantes.svgMY1
		totalDay.setAttribute('text-anchor', 'end');
		if (dayData.totalAmount != 0)
			totalDay.textContent = dayData.totalAmount;

		var x1 = parseInt(dayData.posX) + 10;
		var y1 = parseInt(dayData.posY) + 24;
		var x2 = parseInt(dayData.posX) + parseInt(160) - 10;
		var y2 = parseInt(dayData.posY) + 24;
		
		path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
		path.setAttribute('stroke', 'black');
		path.setAttribute('d', "M" + x1 + " " + y1  + //Constantes.svgMX1 Constantes.svgMY2 
								   " L" + x2 + " " + y2); //Constantes.svgMX1 Constantes.svgMY2

		groupEntries = document.createElementNS('http://www.w3.org/2000/svg', 'g');
		groupEntries.setAttribute('id', "group_entries_" + id);
		groupEntries.setAttribute('class', 'entries');
		
		for (var eIndex = 0; eIndex < dayData.entries.length; eIndex++) {
			entryData = dayData.entries[eIndex];
			
			categorie = document.createElementNS('http://www.w3.org/2000/svg', 'text');
			categorie.setAttribute('id', index + "_categorie_" + eIndex);
			categorie.setAttribute('x', parseInt(dayData.posX) + 10); //Constantes.svgMX3
			categorie.setAttribute('y', (parseInt(dayData.posY) + 20)*(eIndex+1) + 20); //Constantes.svgMY1
			categorie.setAttribute('style', 'fill:' + entryData.color);
			categorie.setAttribute('width', '70');
			categorie.textContent = entryData.categorie;

			money = document.createElementNS('http://www.w3.org/2000/svg', 'text');
			money.setAttribute('id', index + "_money_" + eIndex);
			money.setAttribute('x', parseInt(dayData.posX) + 150);
			money.setAttribute('y', (parseInt(dayData.posY) + 20)*(eIndex+1) + 20);
			money.setAttribute('style', 'fill:' + entryData.color);
			money.setAttribute('width', '55');
			money.setAttribute('text-anchor', 'end');
			money.textContent = entryData.amount + " " + "€";

			groupEntries.appendChild(categorie);
			groupEntries.appendChild(money);
			
		}
		group.appendChild(day);
		group.appendChild(dayOfMonth);
		group.appendChild(totalDay);
		group.appendChild(path);
		group.appendChild(groupEntries);
		
		month.appendChild(group);
	}
	
	//hideLoading();

//	if (direction == "left")
//		document.getElementById("calendar").insertBefore(month, document.getElementById("calendar").firstElementChild);
//	else document.getElementById("calendar").insertBefore(month, null);
	
	document.getElementById("calendar").appendChild(month);
	
	$(month).attr('class', 'animate').css('opacity', '1');
	enableMoveButtons();
};

function disableMoveButtons() {
	$('#leftarrow').css('opacity', '0.4').attr('onclick', '');
	$('#rightarrow').css('opacity', '0.4').attr('onclick', '');
};

function enableMoveButtons() {
	$('#leftarrow').css('opacity', '1').attr('onclick', 'move("left")');
	$('#rightarrow').css('opacity', '1').attr('onclick', 'move("right")');
};
