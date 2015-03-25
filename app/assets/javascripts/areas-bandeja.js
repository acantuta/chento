//= require angular
// without turbolinks
var app = angular.module("app",[]);
app.controller("AreaBandejaController",['$scope','$http',function($scope, $http){
	$scope.esta_cargando  = false;
	$scope.$watch("area_id",function(v){
		if(v){
			$scope.init();
		}
	});
	$scope.$watch('current_tipo_bandeja',function(v){
		if(v){
			for(var i in $scope.tipos_bandeja){
				b = $scope.tipos_bandeja[i]
				if( b.id == v ){
					$scope.load_movimientos(b);
					break;
				}
			}
		}
	});

	$scope.set_tipos_bandeja = function(){
		$scope.tipos_bandeja = [
		{
		'id'  : 'documentos_esperando',
		'url' : '/areas/base/' + $scope.area_id + '/documentos_esperando.json',
		'nombre' : 'Por despachar'
		},
		{
		'id' : 'documentos_recibir',
		'url' : '/areas/base/' + $scope.area_id + '/documentos_recibir.json',
		'nombre' : 'Por recibir'
		},
		{
		'id' : 'documentos_recibidos',
		'url' : '/areas/base/' + $scope.area_id + '/documentos_recibidos.json',
		'nombre' : 'Recibidos físicamente'
		}
		];
		$scope.current_tipo_bandeja = $scope.tipos_bandeja[0].id;
	}

	$scope.load_movimientos = function(tipo_bandeja){
		$scope.esta_cargando = true;
		$scope.movimientos = null;
		$http({
			method: 'get',
			url: tipo_bandeja.url
		})
		 .success(function(d){
		 	$scope.movimientos = d;
		 	$scope.esta_cargando = false;
		 })
		 .error(function(){
		 	$scope.esta_cargando = false;
		 });
	}

	$scope.recibir_documento = function(movimiento){
		$http({
			method: 'post',
			url: '/areas/base/' + $scope.area_id + '/recibir_documento.json',
			params: {
				docmovimiento_id: movimiento.id
			}
		})
		 .success(function(d){
		 	console.log('success');
		 	console.log(d);
		 })
		 .error(function(d){
		 	console.log('error');
		 });
	}

	$scope.init = function(){
		$scope.set_tipos_bandeja();
	}
	
}]);