//ngRestAngular

var app = angular.module("confizHRM", ['ngSanitize']);

app.config(function($routeProvider) {

  $routeProvider.when('/login', {
    templateUrl: 'templates/login.html',
    controller: 'LoginController'
  });

  $routeProvider.when('/employees', {
    templateUrl: 'templates/employees.html',
    controller: 'EmployeesController',
    resolve: {
      employees: function(EmployeeService) {
        return EmployeeService.get();
      }
    }
  });
  
  $routeProvider.when('/employee/new', {
    templateUrl: 'templates/employees/new.html',
  });
  
  $routeProvider.when('/employee/:employeeID/edit', {
    templateUrl: 'templates/employees/edit.html',
    controller: 'EmployeesController',
    resolve: {
      employees: function(EmployeeService) {
        return EmployeeService.getEmployee();
      }
    }
  });

  $routeProvider.when('/employee/:employeeID', {
    templateUrl: 'templates/employees/show.html',
    controller: 'EmployeesController',
    resolve: {
      employees: function(EmployeeService) {
        return EmployeeService.getEmployee();
      }
    }
  });

  $routeProvider.otherwise({redirectTo: '/login'});

});

app.run(function($rootScope, $location, AuthenticationService, FlashService, Navigation) {
  var routesThatRequireAuth = ['/employees'];
  var routesIfLogin = ['/login'];

  $rootScope.$on('$routeChangeStart', function(event, next, current) {
    if (_(routesThatRequireAuth).contains($location.path()) && !AuthenticationService.isLoggedIn()) {
      $location.path('/login');
      FlashService.show("Please log in to continue.");
    } else if (_(routesIfLogin).contains($location.path()) && AuthenticationService.isLoggedIn()) {
      $location.path('/employees');
    }

    if (_(routesIfLogin).contains($location.path())) {
      Navigation.hideNav();
    } else {
      Navigation.showNav();
    }

  });

});








