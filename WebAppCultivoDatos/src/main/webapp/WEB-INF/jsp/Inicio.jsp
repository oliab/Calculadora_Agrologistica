<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="wAppCultivoDatos">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Cultivo de Datos</title>
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
		<link rel="stylesheet" href="css/ext/jquery.dataTables.min.css">
		<link rel="stylesheet" href="css/ext/buttons.dataTables.min.css">
		<link rel="stylesheet" href="css/ext/responsive.dataTables.min.css">
		<link rel="stylesheet" href="css/ext/angular-material.min.css">
		<link rel="stylesheet" href="css/ext/leaflet.css">		
		<link rel="stylesheet" href="css/ext/font-awesome.min.css">
		<link rel="stylesheet" href="css/ext/bootstrap.min.css">
		<link rel="stylesheet" href="css/master.css">
		<link rel="icon" type="image/png" href="img/logo.png" />
	</head>
	<body id="ctrlPrincipal" ng-controller="controller">
		
		<encabezado-control> </encabezado-control>		
		<div class="container">
			<div class="row mt20">
				<div class="col-lg-12">				
					<h3>Calculadora AgroLogística</h3>
             		<p>Calcula los costos de comercialización y distribución para tu cultivo</p>	             		             		
             		<div class="row">		             				        
             			 <div class="col-lg-3">		
             				<form name="calcForm">
			             		<stepper class="col-lg-12" sections="sections" data="datosCalculadora">
			             			<div class="col-lg-12">		             					
		             					 <md-button class='next-step  button btn-primary btn-sm pull-right' ng-click="calcularRuta()">
							        		Calcular ruta
							      		</md-button>
			             			</div>									     	
						    	 </stepper>
					    	 </form>	
					    </div>	             		
             			<div class="col-lg-9">	             											    	              				             	
             				<leaflet class="mapControl" lf-center="mapCenter" markers="markerSitio" geojson="geoRuta" >  </leaflet>       	             				     			
             			</div>             		
             		</div>	             		
				</div>				
			</div>	
			<div class="row mt50">				
			 	<div class="col-lg-12">
			 		  <h3>Resultados:</h3>
			 		  <div ng-show="datosCalculadora.txtCultivo != null">
			 		    <br><small>*Los resultados mostrados en la siguiente página únicamente son una referencia aproximada</small>
			 		  	<br>{{datosCalculadora.txtCultivo}}, {{datosCalculadora.cantidad}} 
			 		  	<span ng-show="datosCalculadora.umedida==1">Kg</span>
			 		  	<span ng-show="datosCalculadora.umedida==2">Ton</span>
			 		  	<span>, Precio diesel por litro: $19.6</span>	
			 		  </div>
				</div>				
			</div>
			<div class="row mt20 mb50">
		  		<div id="tblResultados" class="col-lg-12 display nowrap" style="width:100%">
	                <table id="lstResultados" class="hover stripe" style="width: 100%;font-size:14px;"></table>
	            </div>
		  	</div>
		</div>	
		<!--<piepagina-control> </piepagina-control>-->
		<div class="_loader">
			<div class="loader"></div>
		</div>		
	</body>
	
	<script src="js/ext/jquery.js"></script>
	<script src="js/ext/jquery.dataTables.min.js"></script>
	<script src="js/ext/dataTables.responsive.min.js"></script>
	<script src="js/ext/dataTables.buttons.min.js"></script>
	<script src="js/ext/buttons.colVis.min.js"></script>
	<script src="js/ext/buttons.flash.min.js"></script>
	<script src="js/ext/jszip.min.js"></script>
	<script src="js/ext/pdfmake.min.js"></script>	 
	<script src="js/ext/vfs_fonts.js"></script>
	<script src="js/ext/buttons.html5.min.js"></script>
	<script src="js/ext/buttons.print.min.js"></script>
	<script src="js/ext/moment.js"></script>
	<script src="js/ext/bootstrap.min.js"></script>
    <script src="js/ext/angular.min.js"></script> 
    <script src="js/ext/angular-locale_es-mx.js"></script>    
    <script src="js/ext/angular-animate.min.js"></script>
    <script src="js/ext/angular-aria.min.js"></script>
    <script src="js/ext/angular-messages.min.js"></script>
    <script src="js/ext/angular-material.min.js"></script>
    <script src="js/ext/leaflet.js"></script>
    <script src="js/ext/angular-leaflet-directive.min.js"></script>
    <script src="js/inicio.js"></script>
    <script src="js/encabezado.js"></script>
    <script src="js/piepagina.js"></script>
    <script src="js/stepper.js"></script>
        
    <script>
	    function consultarRuta(ruta) {
	    	var scope = angular.element(document.getElementById('ctrlPrincipal')).scope();
            scope.verRuta(ruta);
	    }
    </script>
</html>