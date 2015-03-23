//= require angular
// without turbolinks
var app = angular.module("app",[]);
app.controller("AreaAsignacionController",['$scope','$http',function($scope, $http){
	
	$scope.$watch( 'current_area', function(a){
		if(a){
			$scope.load_current_area();
		}
	});

	$scope.cargar_areas = function(){
		console.log("cargando areas...");
		$http({
			method: 'get',
			url: '/admin/areas.json'
		})
		  .success(function(data){		  
		  	$scope.areas = data;
		  })
		  .error(function(){

		  });
	}

	$scope.buscar_users = function(){		
		$http({
			url: '/admin/users.json',
			params: {
				search: $scope.search_user
			}
		})
		.success(function(r){
			$scope.users = r;			
		})
		.error(function(r){

		});
	}

	$scope.set_current_area = function(area){
	  $scope.current_area = area ;  
	}

	$scope.init = function(){
		$scope.cargar_areas();
	}

	$scope.add_user_to_current_area = function(user){
	  $http({
	  	method: 'post',
	  	url: '/admin/areas/'+$scope.current_area.id+'/asignar_user.json',
	  	data: {
	  		user: user
	  	}
	  })
	   .success(function(d){
	   		$scope.load_current_area();
	   })
	   .error(function(d){
	   	console.log('Error.');
	   });
	}
	
	$scope.delete_userasignacion_from_area = function( asignacion ){
		var url_asignacion = '/admin/areas/' + asignacion.area_id + '/destroy_asignacion.json';
		console.log(asignacion);
		$http({
			method: 'delete',
			url: url_asignacion,
			params: {
				asignacion_id: asignacion.id
			}
		})
		  .success(function(){
		  	$scope.load_current_area();
		  })
		  .error(function(){

		  });
	}

	$scope.load_current_area = function(){
		$scope.area_is_loading = true;
		$http({
			method: 'get',
			url: '/admin/areas/'+$scope.current_area.id+'.json'
		})
		  .success(function(d){
		  	$scope.area_is_loading = false;
		  	$scope.data_of_current_area = d;
		  })
		  .error(function(d){
		  	$scope.area_is_loading = false;
		  });
	}

	$scope.clear_current_area = function(){
		$scope.current_area = null;
		$scope.users = null;
	}
	$scope.init();
}]);