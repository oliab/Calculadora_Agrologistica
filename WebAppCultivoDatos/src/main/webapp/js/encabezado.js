( function() {
    var app = angular.module('encabezadoModule', []);		
    app.directive("encabezadoControl",  function () {
        return  {
            restrict: 'E',
            templateUrl:  'encabezado',
            controller: function ($scope, $http, $timeout,$rootScope)  {  
                
            }            
        };
    });	
})();