angular.module('stepper.directives').directive('stepper', ['$rootScope', '$compile', '$timeout', '$document',
  function($rootScope, $compile, $timeout, $document) {
    return {
      restrict: 'E',
      scope: {
        sections: '=',
        data: '='
      },
      transclude: true,
      templateUrl: 'calculadora',
      controller: function($rootScope, $scope, $element) {
        var selected = 0;
        $scope.switchSections = function(nextStepIdx, source) {
    	  $(".step-container").show();
          $scope.steps = $scope.steps || $('.stepper .step');
          var nextStep = $($scope.steps[nextStepIdx]);
          $scope.steps.each(function(_, step) {
            $(step).removeClass('active');
          });
          selected = nextStepIdx;
          nextStep.addClass('active');
        };
        $scope.selected = function(idx) {
          return selected === idx;
        };
        $scope.cerrarSection = function() {
        	$(".step-container").hide();
        };
        $scope.compileSection = function(sectionName, options, idx) {
          let el = $compile(
            '<' + sectionName + ' data="data"></' + sectionName + '>'
          )($scope);
          $element.find(
            '.step:nth-child(' + (idx + 1) + ') .step-content').append(el);
        };
      },
      link: function(scope, element, attrs) {
        $timeout(function () {
          scope.sections.forEach(function(section, idx) {
            scope.compileSection(section.directive, section.options, idx);
          });
        }, 0);
      }
    };
  }]);



angular.module('stepper.directives').directive('cultivo',
  function() {
    return {
    	scope: { data: '=' },
        restrict: 'E',
        templateUrl: 'cultivo',
        controller: function($rootScope, $scope, $element, $http) {
        	
        	$scope.cultivos= [];
        	$scope.cultivo;        	
        	
            $scope.getCultivos = function() {
            	$http.post("cultivos")
		            .then(function(result) {	            	
		            $scope.cultivos = result.data;
		             return result.data;
	            }).catch(function (data) {
	            	$scope.cultivos = [];
	            });
            }
                                    
            $scope.getCultivos();
                                    
            $scope.buscarCultivos = function(consulta) {
            	return  consulta ? $scope.listar_cultivos().filter( $scope.filtrarCultivos(consulta) ) : $scope.listar_cultivos();    	 
    	    }
            
            $scope.cultivoSeleccionado = function(cultivo) {
            	$scope.cultivo = null;
            	$scope.data.cultivo = null;
            	if(cultivo != null) {
            		$scope.cultivo = cultivo;
            		$scope.data.cultivo = cultivo.clave;
            		$scope.data.txtCultivo = cultivo.cultivo;
            	}               
            }            
        	
            $scope.listar_cultivos = function() {          
                return $scope.cultivos.map( function (lst) {
                  lst.value = lst.cultivo.toLowerCase();
                  return lst;
                });
            }
                        
            $scope.filtrarCultivos = function(consulta) {
                var rconsulta = angular.lowercase(consulta);
                return function filterFn(item) {
                  return (item.value.indexOf(rconsulta) === 0);
                };
            }
        }
    };
  }
);


angular.module('stepper.directives').directive('transporte',
  function() {
    return {
      scope: { data: '=' },
	  restrict: 'E',
      templateUrl: 'vehiculo',
      controller: function($scope, $element, $sce, $http) {
    	      	  
    	  $scope.vehiculos=[];
    	  $scope.catVeh=[];
    	  $scope.ejes=[];
    	   
    	  $scope.getCatVehiculos = function() {
            	$http.post("catVehiculos")
  		            .then(function(result) {	            	
  		            $scope.catVeh = result.data;
  		             return result.data;
  	            }).catch(function (data) {
  	            	$scope.catVeh = [];
  	            });
          }
    	  
    	  $scope.getVehiculos = function() {
          	$http.post("vehiculos")
		            .then(function(result) {	            	
		            $scope.vehiculos = result.data;
		             return result.data;
	            }).catch(function (data) {
	            	$scope.vehiculos = [];
	            });
          }
    	  
    	  $scope.getEjes = function() {
            	$http.post("ejes")
  		            .then(function(result) {	            	
  		            $scope.ejes = result.data;
  		             return result.data;
  	            }).catch(function (data) {
  	            	$scope.ejes = [];
  	            });
          }
    	  
    	  $scope.getCatVehiculos();
    	  $scope.getVehiculos();
    	  $scope.getEjes();
    	               
          $scope.to_trusted = function(html_code) {
              return $sce.trustAsHtml(html_code);
          }
      }
    };
  }
);


angular.module('stepper.directives').directive('ubicacion',
  function() {
    return {    	
	  scope: { data: '=' },
      restrict: 'E',
      templateUrl: 'ubicacion',
      controller: function($rootScope, $scope, $element, $http) {
    	  
    	  $scope.sitios = [];
          $scope.selSitio = null;
          $scope.txtSitio = null;
          $scope.lenSitio=0;
          
          
          $scope.buscarSitiosSakbeJson = function (txtSitio) {        	
          	if(txtSitio == undefined) return;
          		$scope.lenSitio = txtSitio.length;
  	        	var urlApiBusqueda = "http://gaia.inegi.org.mx/sakbe/wservice?make=SD&buscar=#buscar&key=#token&type=json";	
  		       	var token = '#AgregarToken';
  		       	var urlApiBusquedaTmp = urlApiBusqueda.replace('#buscar',txtSitio);	
  		       	urlApiBusquedaTmp = urlApiBusquedaTmp.replace('#token',token);	
  		       	
  		       	$scope.sitios = [];
  	        	return $http.get(urlApiBusquedaTmp)
  		            .then(function(result) {	            	
  		             $scope.sitios = result.data;
  		             return result.data;
  	            }).catch(function (data) {
  	            	console.log("error", data);
  	            	return $scope.sitios;  	            	
  	            });
          }
          
          
           $scope.cambioSitio = function(sitio) {
        	   if(sitio != undefined) { 
		      	   $scope.data.idDes = sitio.id_dest;
		           $scope.data.origen=sitio.nombre;          	
		           sitio = JSON.parse(sitio.geojson);
		           $scope.data.lat =  sitio.coordinates[1];
		           $scope.data.lng = sitio.coordinates[0];              	
		           $rootScope.$$childHead.addMapaOrigen(sitio.coordinates[1], sitio.coordinates[0], 12, $scope.data.origen);
        	   } else {
        		   $scope.data.idDes = null;
        		   $rootScope.$$childHead.removeMapSitio();
        	   }
          }
          

          $scope.addMapSitio = function(lat, lng, zoom, txt) {        	  
        	  $(".step-container").hide();        	  
          	  $scope.data.mapa.lat = lat;
      		  $scope.data.mapa.lng = lng;
          	  $scope.data.mapa.zoom = zoom;
              
        	  $("._loader").show();
              $http.post('http://localhost:8080/ruta', $scope.data).then(function (response) {
          		if (response.data)
          			$scope.data.rutas= response.data;          			
          			$("._loader").hide();
          			
              	}, function (response) {	
              		alert("Error al recuperar las rutas: "  + response.statusText);
              		console.log("error");
              		$("._loader").hide();
          	});
          };
      }
    };
  }
);