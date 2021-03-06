//= require angular
// without turbolinks
var app = angular.module("app",[]);
app.controller("AreaBandejaController",['$scope','$http',function($scope, $http){
	$scope.esta_cargando  = false;
	$scope.current_page = 1;
	$scope.$watch("area_id",function(v){
		if(v){
			$scope.init();
		}
	});
	$scope.$watch('current_tipo_bandeja',function(v){
		if(v){
			$scope.cargar_movimientos_segun_current_tipo_bandeja(v);
		}
	});

	$scope.$watch('current_page', function(v){
		if(v){
			$scope.refrescar_movimientos_bandeja();
		}
	});

	$scope.cargar_movimientos_segun_current_tipo_bandeja = function (v) {
		for(var i in $scope.tipos_bandeja){
				var b = $scope.tipos_bandeja[i]
				if( b.id == v ){
					$scope.load_movimientos(b);
					break;
				}
		}
	}

	$scope.refrescar_movimientos_bandeja = function(){
		$scope.cargar_movimientos_segun_current_tipo_bandeja($scope.current_tipo_bandeja);
	}


	$scope.$watch('texto_buscar', function (v) {
		if(v != undefined && v != ""){
			$scope.cargar_movimientos_segun_current_tipo_bandeja($scope.current_tipo_bandeja);
		}
	});
	$scope.set_tipos_bandeja = function(){
		$scope.tipos_bandeja = [
		{
		'id'  : 'documentos_todos',
		'url' : '/areas/base/' + $scope.area_id + '/documentos_todos.json',
		'nombre' : 'Todos'
		},
		{
		'id'  : 'documentos_enviados',
		'url' : '/areas/base/' + $scope.area_id + '/documentos_enviados.json',
		'nombre' : 'Enviados'
		},
		{
		'id'  : 'documentos_esperando',
		'url' : '/areas/base/' + $scope.area_id + '/documentos_esperando.json',
		'nombre' : 'No enviados'
		},
		{
		'id' : 'documentos_recibir',
		'url' : '/areas/base/' + $scope.area_id + '/documentos_recibir.json',
		'nombre' : 'No recibidos'
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
			url: tipo_bandeja.url,
			params: {
				texto_buscar: $scope.texto_buscar,
				page: $scope.current_page
			}
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
		 	movimiento.visible = false;
		 })
		 .error(function(d){
		 	console.log('error');
		 });
	}

	$scope.cambiar_estado_documento = function (item, estado) {
	  console.log(item);
	  $http({
	  	method: 'post',
	  	url: '/documentos/' + item.documento_id + "/cambiar_estado.json",
	  	data: {
	  		estado: estado
	  	}
	  }).success( function ( data ) {
	  	$scope.refrescar_movimientos_bandeja();	  	
	  }).error( function (data) {
	  	alert("Sucedió un error al cambiar el estado del documento");
	  });
	}

	$scope.reset_page = function(){
		$scope.current_page = 1;
	}

	$scope.siguiente_pagina = function(){
		$scope.current_page += 1;
	}

	$scope.anterior_pagina = function(){
		$scope.current_page -= 1;
	}

	$scope.init = function(){
		$scope.reset_page();
		$scope.set_tipos_bandeja();
	}
	
}]);