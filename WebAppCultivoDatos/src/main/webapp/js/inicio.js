( function() {	   
    var app = angular.module('wAppCultivoDatos', ['encabezadoModule','piepaginaModule','leaflet-directive','ngMaterial','ngMessages','stepper.directives']);
    app.controller('controller',function ($scope, $http, $timeout, $q, $mdDialog, leafletData) {        
    	
    	var local_icons = {
	        default_icon: {},
	        Inicio: {
	            iconUrl: 'img/icnOrigen.png',
                iconSize:     [45, 42]
	        }
	    };
    	    	        
    	angular.extend($scope, {
            defaults: {
                scrollWheelZoom: false
            },
            mapCenter: {
                lat: 19.432579,
                lng: -99.1343368,
                zoom: 4
            },
            markerSitio: {
            	
            }, 
            geoRuta: {
            	
            },
            icons: local_icons,
            events: {
                markers: {
                    enable: ['dragend']
                }
            }
        });
    	
    	
        $scope.datosCalculadora = {        	
        	cultivo: null,
        	txtCultivo:null,
        	cantidad: null,
        	umedida: 1,
        	idVeh: 5,
        	idDes: null,
        	utipo:1,
        	lat: null,
        	lng: null,
        	origen:null,
        	ejes: 0,
        	rutas: [],
        	mapa: $scope.mapCenter,
        	marker: $scope.markerSitio,
        	id_i:null,
        	source_i:null,
        	target_i:null
        }
        
        
        $scope.addMapaOrigen = function(lat, lng, zoom,txt) {
      	  	$scope.mapCenter.lat = lat;
      	  	$scope.mapCenter.lng = lng;
      	  	$scope.mapCenter.zoom = zoom;
      	  	$scope.geoRuta = {};
      	  	$scope.resultados = [];	
      	  	$scope.resetTablaResultados();
        	          
        	            	  
            angular.extend($scope, {
      	      markerSitio: {
                    Inicio: {
                        lat: lat,
                        lng: lng,
                        message: "Inicia: " + txt,
                        focus: true,
                        draggable: true,                                              
                        icon: local_icons.Inicio
                    }
                }
            });
        }
        
       
        $scope.$on("leafletDirectiveMarker.dragend", function(event, args){
        	$scope.dragSitio(args.model.lat, args.model.lng);        	
        });
        
        
        $scope.dragSitio = function(lat, lng) { 
        	var urlApiBusqueda = "http://gaia.inegi.org.mx/sakbe/wservice?make=IL&x=#lon&y=#lat&escala=100000&type=json&key=#token";	
	       	var token = '#AgregarToken';
	       	var urlApiBusquedaTmp = urlApiBusqueda.replace('#lat',lat);
	       	urlApiBusquedaTmp = urlApiBusquedaTmp.replace('#lon',lng);
	       	urlApiBusquedaTmp = urlApiBusquedaTmp.replace('#token',token);	
		       	
	       	$http.get(urlApiBusquedaTmp)
		            .then(function(result) {	            	
		             if(result.data[0].id_routing_net != null) {
		            	 $scope.datosCalculadora.lat= lat;
		            	 $scope.datosCalculadora.lng = lng;
		            	 $scope.datosCalculadora.id_i = result.data[0].id_routing_net;
		            	 $scope.datosCalculadora.source_i = result.data[0].source;
		            	 $scope.datosCalculadora.target_i = result.data[0].target;
		            	 $scope.datosCalculadora.origen = result.data[0].nombre;
		            	 $scope.addMapaOrigen(lat, lng, 12,result.data[0].nombre);
		             } else {
		            		 alert("Lo sentimos, no fue posible recuperar la información de la vialidad más cercana, intente nuevamente");
		            		 $scope.datosCalculadora.id_i = null;
		            		 $scope.datosCalculadora.source_i = null;
		            		 $scope.datosCalculadora.target_i = null;		            		 
		            		 $scope.removeMapSitio();
		            		 $scope.addMapaOrigen(lat, lng, 12,'');		            	 
		             }
		             
            }).catch(function (data) {
            	$scope.datosCalculadora.id_i = null;
           	 	$scope.datosCalculadora.source_i = null;
           	 	$scope.datosCalculadora.target_i = null;
            	alert("Lo sentimos, no fue posible recuperar la información de la vialidad más cercana");
            	$scope.removeMapSitio();
            	$scope.addMapaOrigen(lat, lng, 12,'');
            });
        	
        }

        $scope.removeMapSitio = function() {
            $scope.markerSitio = {};
        }
        
        
        $scope.calcularRuta = function() {        	
        	  var isValid = $scope.validaDatosCalculadora();         	  
        	  if(isValid > 0) {
        		  
        		  switch(isValid) {
        		  		case 1:    alert("Ingrese por favor la información faltante del cultivo"); break;
        		  		case 2:    alert("Ingrese por favor la información de la ubicación del producto"); break;
        		  		
        		  }
        		  
        		  return;
        	  }
      	  
        	  $(".step-container").hide();
      	  
        	  $scope.mapCenter.lat = $scope.datosCalculadora.lat;
    		  $scope.mapCenter.lng = $scope.datosCalculadora.lng;
        	  $scope.mapCenter.zoom = 10;
        	  
        	  $scope.datosCalculadora.rutas=[];
        	  $scope.geoRuta.data = [];
        	  
        	  $("._loader").show();
	          $http.post('http://localhost:8080/ruta', $scope.datosCalculadora).then(function (response) {
	        		if (response.data)
	        			$scope.datosCalculadora.rutas= response.data;  
	        			$scope.mostrarResultados($scope.datosCalculadora.rutas);
	        			$("._loader").hide();
	        		        		
	        		
	            	}, function (response) {	
	            		alert("Error al recuperar las rutas: "  + response.statusText);
	            		console.log("error");
	            		$("._loader").hide();
	        	});
        };
        
       
        
        $scope.verRuta=function(ruta) {
          $("._loader").show();
    	  angular.extend($scope, {
            	markerSitio: {
                    m1: {
                        lat: $scope.datosCalculadora.lat,
                        lng: $scope.datosCalculadora.lng,
                        message: $scope.datosCalculadora.origen,
                        focus: false,
                        draggable: false,
                        icon: local_icons.Inicio
                    },
                    m2: {
                        lat: ruta.lat,
                        lng: ruta.lng,
                        message: ruta.destino,
                        focus: true,
                        draggable: false
                    }
                }
            });
    	  
    	  
      	  $scope.geoRuta.data = JSON.parse(ruta.geojson);
      	  
      	  leafletData.getMap().then(function(map) {
             map.fitBounds([[$scope.datosCalculadora.lat,$scope.datosCalculadora.lng], [ruta.lat,ruta.lng]]);
          });
      	  
      	  $("html,body").scrollTop(0);
      	  $("._loader").hide();
        };
             
        
        var sectionNames = ['Cultivo', 'Transporte', 'Ubicación'];
        $scope.sections = sectionNames.map(function(sectionName) {
          return {
            title: sectionName,
            directive: sectionName.replace(/ó/gi,"o"),
          };
        });
        
        
       
        $scope.tablaResultados = null;
        $scope.resultados = [];
        
        
        $scope.mostrarResultados = function(resultados) {
        	$scope.resultados = [];	       	
        	for(oKey in resultados) {
        		$scope.resultados.push( {
        			utilidad: (oKey * (-1)),
        			utilidad: (oKey * (-1)),
        			costo: resultados[oKey][0].costo_caseta,
        			combustible: resultados[oKey][0].pCombustible,
        			distancia: resultados[oKey][0].long_km,
        			destino: resultados[oKey][0].destino,
        			precio: resultados[oKey][0].pUnitario,
        			fecha: resultados[oKey][0].fPrecio,
        			duracion: resultados[oKey][0].tiempo_min,
        			ruta: resultados[oKey][0]
        		});         		        		       
        	}
        	
        	$scope.resetTablaResultados();        	
        	$scope.tablaResultados = $('#lstResultados').dataTable( {  
                  data: $scope.resultados
        	});        	
        	
        };
        
        
        $scope.resetTablaResultados = function() {        	
        	if($scope.tablaResultados==null) {        		
        		$.extend( true, $.fn.dataTable.defaults, {     
        			dom: 'Bfrtip',
        	        buttons: [
        	        			{
        	        				extend: 'colvis',
        	        				text:'Columnas'
        	        			},
        	        			{
        	        				extend: 'excel',
        	        				text:'Excel',
        	        				exportOptions: {
        	        			        stripNewlines: true,
        	        			        stripHtml: true
        	        			    }
        	        			},        	        			
        	        			{
        	        				extend: 'print',
        	        				text:'Imprimir',
        	        				exportOptions: {
        	        			        stripNewlines: true,
        	        			        stripHtml: false
        	        			    }
        	        			}
        	         ],
        			responsive: {
        				details: {
        	                renderer: function ( api, rowIdx, columns ) {
        	                    var data = $.map( columns, function ( col, i ) {
        	                        return col.hidden ?
        	                            '<tr data-dt-row="'+col.rowIndex+'" data-dt-column="'+col.columnIndex+'">'+
        	                                '<td>'+col.title+':'+'</td> '+
        	                                '<td>'+col.data+'</td>'+
        	                            '</tr>' :
        	                            '';
        	                    } ).join('');
        	 
        	                    return data ?
        	                        $('<table/>').append( data ) :
        	                        false;
        	                }
        				}
        			},
        			columns: [        				
        				{ title: 'Destino', data:'destino'},
        				{ title: 'Precio(Kg)', data:'precio'},
        				{ title: 'Volumen', data:''},
        				{ title: 'Precio venta', data:''},
        				{ title: 'Costo total', data:'costo'},        				
                        { title: 'Utilidad', data:'utilidad'},                        
                        { title: 'Desgloce costo', data:'costo'},
                        { title: 'Distancia(Km)', data:'distancia'},
                        { title: 'Duración(Hr)', data:'duracion'},                                                
                        { title: 'Fecha precio', data:'fecha'},
                        { title: 'Acciones', data:''}                       
                    ],
                    "language": {
                        "lengthMenu": "Mostrar _MENU_ por Página",
                        "zeroRecords": "NO hay información disponible",
                        "info": "_PAGE_ / _PAGES_",
                        "infoEmpty": "No hay información disponible",
                         "emptyTable": "No hay información disponible",
                        "infoFiltered": "(Filtro de _MAX_ total registros)",
                        "sSearch": "Buscar",
                        "oPaginate": {
                                "sFirst": "Siguiente",
                                "sPrevious": "Anterior",
                                "sNext": "Siguiente",
                                "sLast": "Anterior"
                        }
                    },  
                    "order": [
                    			[ 5, "desc" ]
                    ],
                    "aoColumnDefs": [
                    	                    	
                    	 {
                             "aTargets": [1], //precio kg
                             "mRender": function ( data, type, full ) {
                             	var valor = (parseFloat(data).toFixed(2)).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                 return "&nbsp$" + valor;
                             }
                         },                     	
                         {
                             "aTargets": [2], //volumen
                             "mRender": function ( data, type, full ) {
                            	 var valor = $scope.datosCalculadora.cantidad;
                             	 valor+= $scope.datosCalculadora.umedida == 1 ? ' Kg' : ' Ton';
                                 return valor;
                             }
                         }, 
                         {
                             "aTargets": [3],//precio venta
                             "mRender": function ( data, type, full ) {
                            	var cantidad = $scope.datosCalculadora.umedida == 1 ? $scope.datosCalculadora.cantidad 
											 : $scope.datosCalculadora.cantidad * 1000;

								var valor = parseFloat(full.precio) * cantidad;
								valor = (valor.toFixed(2)).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                return "&nbsp$" + valor;
                             }
                         }, 
                         {
                             "aTargets": [4],
                             "mRender": function ( data, type, full ) {   
                         	   var total = ((parseFloat(data) + parseFloat(full.combustible)).toFixed(2)).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                return "&nbsp$" + total;
                             }
                         }, 
                         
                    	{
                    		"aTargets": [5],
                    		"mRender": function ( data, type, full ) {
                    			var valor = parseFloat(data).toFixed(2); 
                    			if( valor > 0) {
                    				return "&nbsp$" + valor.replace(/\d(?=(\d{3})+\.)/g, '$&,');
                    			}
                    			
                				return "&nbsp$" + valor.replace(/\d(?=(\d{3})+\.)/g, '$&,');                    		
                            }                    		
                    	},
                        {
                            "aTargets": [6],
                            "mRender": function ( data, type, full ) {
                                var valorT = (parseFloat(data).toFixed(2)).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                          	    var valorC = (parseFloat(full.combustible).toFixed(2)).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                return "&nbsp&nbspTransporte:<br>&nbsp&nbsp$" + valorT + "<br>&nbsp&nbspCombustible:<br>&nbsp&nbsp$ " + valorC;
                            }
                        },
                        {
                            "aTargets": [7],
                            "mRender": function ( data, type, full ) {
                            	var valor = (parseFloat(data).toFixed(2)).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                            	return  valor;
                            }
                        },
                        {
                            "aTargets": [8],
                            "mRender": function ( data, type, full ) {
                            	var valor = ((parseFloat(data)/60).toFixed(2)).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                            	return  valor;
                            }
                        },
                       
                        {                        	
                        	"aTargets": [9],
                            "mRender": function ( data, type, full ) {
                                return moment(data).format("DD/MM/YYYY");
                            }                        	
                        },
                        {
                        	"aTargets": [10],
                            "mRender": function ( data, type, full ) {
                                return "<button class='button btn btn-info btn-sm' onclick='consultarRuta(" + JSON.stringify(full.ruta) + ")'>Ver ruta</button>";
                            }                                                	
                        }
                    ]
                });        		        	
        	}
        	        	
        	
        	if($scope.tablaResultados != null) {
                $scope.tablaResultados.fnDestroy();
            }
        };
       
        
        
        $scope.validaDatosCalculadora = function() {
        	
        	if($scope.datosCalculadora.cultivo == null 
        	   ||  $scope.datosCalculadora.cantidad == undefined || $scope.datosCalculadora.cantidad == null ) {
        		
        		return 1;
        	}
        	
        	
			if($scope.datosCalculadora.utipo == 1 && $scope.datosCalculadora.idDes == null ) {
        		return 2;
        	}
        	
			
			if($scope.datosCalculadora.utipo == 2 && $scope.datosCalculadora.id_i == null ) {
        		return 2;
        	}
        	
        	return 0; 
        }
        
              
        
        $scope.$watch('datosCalculadora.utipo', function(value) {
        	
        	$scope.datosCalculadora.idDes = null;
        	$scope.datosCalculadora.id_i = null;
 		    $scope.removeMapSitio();
 		   
 		   
            if(value == 2) { //Coordenada
            	try{
            	 if (navigator.geolocation) {
            		 $("._loader").show();
                     navigator.geolocation.getCurrentPosition($scope.coordenadas);
            	 } else{   
            		 $("._loader").hide();
            		 var lat= 19.371069;
                     var lng= -99.104018;
                     $scope.datosCalculadora.lat =  lat;
                     $scope.datosCalculadora.lng = lng;           
                     $scope.addMapaOrigen(lat, lng, 12,'');
                 }     }
            	catch(error) {
            		var lat= 19.371334;
                    var lng= -99.103675;
                    $scope.datosCalculadora.lat =  lat;
                    $scope.datosCalculadora.lng = lng;           
                    $scope.coordenadasEx(lat, lng, 12,'');
            	}
           } 
        });
        
        $scope.coordenadas = function(position) {
        	$("._loader").hide();
            var lat = position.coords.latitude;
            var lon = position.coords.longitude;        	
            $scope.datosCalculadora.lat =  lat;
            $scope.datosCalculadora.lng = lon;             
            $scope.dragSitio(lat, lon);
                        
        };
        
        $scope.coordenadasEx = function(lat, lon) {
        	$("._loader").hide();        	
            $scope.datosCalculadora.lat =  lat;
            $scope.datosCalculadora.lng = lon;             
            $scope.dragSitio(lat, lon);
                        
        };
        
        
    	$timeout(function() {
    		 

    		 
        });    	
    });
    
    
    angular.module("stepper.directives", []);
    
})();