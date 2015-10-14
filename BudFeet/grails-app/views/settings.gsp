<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
	<meta name="layout" content="main" />
	<title>List Cars</title>

		<asset:javascript src="jquery-1.9.1.js"/>
		<asset:javascript src="jquery-ui.js"/>
		<asset:javascript src="dragdealer.js"/>
		<asset:javascript src="colorpicker.js"/>
		<asset:javascript src="colorpicker-color.js"/>
		<asset:stylesheet src="bootstrap-colorpicker.css"/>

	<style type="text/css">
		.extendedMenu {
			color:white;
			opacity:0.6;
			background:#212121;
			list-style-type: none;
			padding:3px;
		}
		
		li:hover {
			cursor:pointer;
			background:#a1a1a1;
		}
		
		.popbg {
			position: fixed;
			background-color: #000;
			height: 100%;
			width: 100%;
			top: 0;
			left: 0;
			opacity: 0.5;
			z-index: 98;
		}
		
		.fenetre {
			display:block;
			text-align:center;
			background: none repeat scroll 0 0 #fff;
			border: 1px solid #000;
			font-size: 1.1em;
			width: 420px;
			margin:0 auto;
			padding:20px;
			position: absolute;
			z-index: 101;
		}
		
		.dragdealer {
		  background: #e1e1e1;
		  height: 40px;
		  border-radius: 3px;
		}
		  .dragdealer .red-bar {
		    height: 40px;
		    font-size: 16px;
		    line-height: 40px;
		    border-radius: 3px;
		  }
	</style>

	<script type="text/javascript">
		function openPopup(element){
			document.getElementById('popupbg').style="display:block";
			document.getElementById('popupCell').style="display:block";
		};
		function closePopup(){
			document.getElementById('popupbg').style="display:none";
			document.getElementById('popupCell').style="display:none";
		};
		
		function switchCategory(value){
			var select = document.querySelectorAll('*[id^="data_"]');
			for (var index = 0; index < select.length; index++) {
				select[index].style="display:none;";
			}
			document.getElementById("data_" + value).style="display:block;";
		};
	</script>
</head>
<body>
	<div id="popupbg" class="popbg" style="display:none" onclick="closePopup()";></div>
	<div id="popupCell" class="fenetre" style="display:none;">
		<div id="titre" style="text-align:center;border-bottom:1px solid black;margin-bottom:15px;">Make an entry !</div>
		<div style="border-bottom:1px solid black;margin-bottom:15px;text-align:center;padding-bottom:10px;">
			<label for="select_categorie">Select category : </label>
			<select id="select_categorie" style="">
				<option value="grocery" selected="selected">Grocery</option>
				<option value="restaurant">Restaurant</option>
				<option value="clothes">Clothes</option>
				<option value="amusements">Amusements</option>
				<option value="misc">Miscellaneous</option>
			</select>
		</div>
		
		<div id="data" style="display:block;">
			<table style="width:100%;margin-bottom:10px;">
			<tr>
				<td style="width:40%;">
					<div>Color</div>
				</td>
				<td>
					<input id="budget_amount" type="text" />
				</td>
			</tr>
			<tr>
				<td style="width:40%;">
					<div>Amount :</div>
				</td>
				<td>
					<input id="budget_amount" type="text" />
				</td>
			</tr>
			<tr>
				<td style="width:40%;">
					<div>Infos  :</div>
				</td>
				<td>
					<input id="budget_infos" type="text" name="Infos" />
				</td>
			</tr>
			</table>
			<input type="submit" class="btn btn-primary" value="Create"/>
			
		</div>
		
		<div id="data_events" style="display:none;">
			<label for="select_events_type">Type :</label>
			<select id="select_events_type">
				<option value="festival">Festival</option>
				<option value="anniversary">Anniversary</option>
				<option value="family">Family</option>
				<option value="other">Other</option>
			</select>
			<div>
				<label for="events_localisation">Localisation :</label>
				<input id="events_localisation" type="text"/>
			</div>
			<div>
				<label for="events_infos">Infos        :</label>
				<input type="events_infos" name="Infos" />
			</div>
			<input type="submit" class="btn btn-primary" value="Create"/>
		</div>
		
		<div id="data_training" style="display:none;">
			<label for="select_events_type">Muscle group :</label>
			<select id="select_events_type">
				<option value="cs">Ceinture scapulaire</option>
				<option value="ms">Membres supérieurs</option>
				<option value="mi">Membres inférieurs</option>
				<option value="pa">Paroi abdominale</option>
				<option value="pd">Paroi dorsale</option>
			</select>
			<div>
				<label for="training_amount">Muscle : (g:select)</label>
				<input id="training_amount" type="text"/>
			</div>
			<div>
				<label for="training_intensity">Intensity : </label>
				<input id="training_intensity" type="text" name="Infos" />
			</div>
			<div>
				<label for="training_pain">Pain level : </label>
				<input id="training_pain" type="text" name="Infos" />
			</div>
			<input type="submit" class="btn btn-primary" value="Create"/>
		</div>
		
		<div id="data_todolist" style="display:none;">
			<div>
				<label for="text_amount">Todo : </label>
				<input id="text_amount" type="text"/>
			</div>
			<input type="submit" class="btn btn-primary" value="Create"/>
		</div>
	</div>

	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="height:200px">
	
	<div id="demo-simple-slider" class="dragdealer">
            <div class="handle red-bar">drag me</div>
          </div>
	
	<script type="text/javascript">
	$(function() {
		  new Dragdealer('demo-simple-slider');
		  });
	</script>
	
	<div class="input-group demo2">
    <input type="text" value="" class="form-control" />
    <span class="input-group-addon"><i></i></span>
</div>
<script>
    $(function(){
        $('.demo2').colorpicker();
    });
</script>
	
	</div>

	<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1" style="vertical-align:middle;height:400px;padding:0px;;background:#b1b1b1">
		<input type="button" class="btn btn-primary" value="Categories" onmouseover="document.getElementById('categories_extend').style='display:block';" style="width:100%;"
			   onmouseout="document.getElementById('categories_extend').style='display:none;'"/>
	</div>
	<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1" style="vertical-align:middle;height:400px;padding:0px;">
		<div style="display:inline;width:100%;height:100%" onmouseover="document.getElementById('categories_extend').style='display:block';"
			 onmouseout="document.getElementById('categories_extend').style='display:none;'">
			<ul id="categories_extend" class="extendedMenu" style="display:none">
				<li>Budget</li>
				<li>Events</li>
				<li>Training</li>
				<li>ToDoList</li>
			</ul>
		</div>
	</div>
	
	<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8" style="height:200px">
			<svg version="1.1" width="100%" height="100%" viewBox="0 0 320 320" fill="none" stroke="#000" stroke-linecap="round"
     xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs>
    <path id="r1">
      <animate id="p1" attributeName="d" values="m160,160l0,0 0,0;m130,110l30,-17 30,17;m130,60l30,-17 30,17;m160,20l0,0 0,0" dur="6s" repeatCount="indefinite"/>
      <animate attributeName="stroke-width" values="0;4;4;4;0" dur="6s" repeatCount="indefinite" begin="p1.begin"/>
    </path>
    <path id="r2">
      <animate attributeName="d" values="m160,160l0,0 0,0;m130,110l30,-17 30,17;m130,60l30,-17 30,17;m160,20l0,0 0,0" dur="6s" repeatCount="indefinite" begin="p1.begin+1s"/>
      <animate attributeName="stroke-width" values="0;4;4;4;0" dur="6s" repeatCount="indefinite" begin="p1.begin+1s"/>
    </path>
    <path id="r3">
      <animate attributeName="d" values="m160,160l0,0 0,0;m130,110l30,-17 30,17;m130,60l30,-17 30,17;m160,20l0,0 0,0" dur="6s" repeatCount="indefinite" begin="p1.begin+2s"/>
      <animate attributeName="stroke-width" values="0;4;4;4;0" dur="6s" repeatCount="indefinite" begin="p1.begin+2s"/>
    </path>
    <path id="r4">
      <animate id="p1" attributeName="d" values="m160,160l0,0 0,0;m130,110l30,-17 30,17;m130,60l30,-17 30,17;m160,20l0,0 0,0" dur="6s" repeatCount="indefinite" begin="p1.begin+3s"/>
      <animate attributeName="stroke-width" values="0;4;4;4;0" dur="6s" repeatCount="indefinite" begin="p1.begin+3s"/>
    </path>
    <path id="r5">
      <animate attributeName="d" values="m160,160l0,0 0,0;m130,110l30,-17 30,17;m130,60l30,-17 30,17;m160,20l0,0 0,0" dur="6s" repeatCount="indefinite" begin="p1.begin+4s"/>
      <animate attributeName="stroke-width" values="0;4;4;4;0" dur="6s" repeatCount="indefinite" begin="p1.begin+4s"/>
    </path>
    <path id="r6">
      <animate attributeName="d" values="m160,160l0,0 0,0;m130,110l30,-17 30,17;m130,60l30,-17 30,17;m160,20l0,0 0,0" dur="6s" repeatCount="indefinite" begin="p1.begin+5s"/>
      <animate attributeName="stroke-width" values="0;4;4;4;0" dur="6s" repeatCount="indefinite" begin="p1.begin+5s"/>
    </path>
  </defs>
  <use xlink:href="#r1"/>
  <use xlink:href="#r1" transform="rotate(60 160 160)"/>
  <use xlink:href="#r1" transform="rotate(120 160 160)"/>
  <use xlink:href="#r1" transform="rotate(180 160 160)"/>
  <use xlink:href="#r1" transform="rotate(240 160 160)"/>
  <use xlink:href="#r1" transform="rotate(300 160 160)"/>
  <use xlink:href="#r2" transform="rotate(30 160 160)"/>
  <use xlink:href="#r2" transform="rotate(90 160 160)"/>
  <use xlink:href="#r2" transform="rotate(150 160 160)"/>
  <use xlink:href="#r2" transform="rotate(210 160 160)"/>
  <use xlink:href="#r2" transform="rotate(270 160 160)"/>
  <use xlink:href="#r2" transform="rotate(330 160 160)"/>
  <use xlink:href="#r3"/>
  <use xlink:href="#r3" transform="rotate(60 160 160)"/>
  <use xlink:href="#r3" transform="rotate(120 160 160)"/>
  <use xlink:href="#r3" transform="rotate(180 160 160)"/>
  <use xlink:href="#r3" transform="rotate(240 160 160)"/>
  <use xlink:href="#r3" transform="rotate(300 160 160)"/>
  <use xlink:href="#r4" transform="rotate(30 160 160)"/>
  <use xlink:href="#r4" transform="rotate(90 160 160)"/>
  <use xlink:href="#r4" transform="rotate(150 160 160)"/>
  <use xlink:href="#r4" transform="rotate(210 160 160)"/>
  <use xlink:href="#r4" transform="rotate(270 160 160)"/>
  <use xlink:href="#r4" transform="rotate(330 160 160)"/>
  <use xlink:href="#r5"/>
  <use xlink:href="#r5" transform="rotate(60 160 160)"/>
  <use xlink:href="#r5" transform="rotate(120 160 160)"/>
  <use xlink:href="#r5" transform="rotate(180 160 160)"/>
  <use xlink:href="#r5" transform="rotate(240 160 160)"/>
  <use xlink:href="#r5" transform="rotate(300 160 160)"/>
  <use xlink:href="#r6" transform="rotate(30 160 160)"/>
  <use xlink:href="#r6" transform="rotate(90 160 160)"/>
  <use xlink:href="#r6" transform="rotate(150 160 160)"/>
  <use xlink:href="#r6" transform="rotate(210 160 160)"/>
  <use xlink:href="#r6" transform="rotate(270 160 160)"/>
  <use xlink:href="#r6" transform="rotate(330 160 160)"/>
</svg>
	</div>
	
	<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2" style="vertical-align:middle">
<!--		Ceinture scapulaire
	- Trapèzes
	- Grand pectoral
	- Deltoide
	- Grand dorsal

Membres supérieurs 
	- Biceps
	- Triceps
	- Fléchisseurs
	- Extenseurs

Membres inférieurs 
	- Fessier
	- Abducteur
	- Adducteur
	- Ischio-jambiers
	- Quadriceps fémoral
	- Jumeaux

Paroi abdominale
	- Droit de l'abdomen

Paroi dorsale
	- Extenseurs du dos
-->
	</div>
</body>
</html>