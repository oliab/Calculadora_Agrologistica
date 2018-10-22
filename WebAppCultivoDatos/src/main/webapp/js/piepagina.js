( function() {
    var app = angular.module('piepaginaModule', []);		
    app.directive("piepaginaControl",  function () {
        return  {
            restrict: 'E',
            templateUrl:  'piepagina',
            controller: function ($scope, $http, $timeout,$rootScope)  {  
                
            }            
        };
    });	
})();