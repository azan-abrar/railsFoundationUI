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

app.factory("EmployeeService", function($http, $route) {
  return {
    get: function() {
      return $http.get('/employees');
    },
    getEmployee: function() {
      return $http.get('/employees/' + $route.current.params.employeeID);

    }
  };
});

app.factory("Navigation", function($rootScope) {
  return {
    showNav: function() {
      $rootScope.showNavigationBar = true;
    },
    hideNav: function() {
      $rootScope.showNavigationBar = false;
    }
  }
});

app.factory("FlashService", function($rootScope) {
  return {
    show: function(message) {
      $rootScope.flash = message;
    },
    clear: function() {
      $rootScope.flash = "";
    }
  }
});

app.factory("SessionService", function() {
  return {
    get: function(key) {
      return sessionStorage.getItem(key);
    },
    set: function(key, val) {
      return sessionStorage.setItem(key, val);
    },
    unset: function(key) {
      return sessionStorage.removeItem(key);
    }
  }
});

app.factory("AuthenticationService", function($http, $sanitize, SessionService, FlashService) {

  var cacheSession = function() {
    SessionService.set('authenticated', true);
  };

  var uncacheSession = function(credentials) {
    credentials.username = '';
    credentials.password = '';
    SessionService.unset('authenticated');
  };

  var loginError = function(response) {
    FlashService.show(response.flash);
  };

  var sanitizeCredentials = function(credentials) {
    return {
      username: $sanitize(credentials.username),
      password: $sanitize(credentials.password)
    };
  };

  return {
    login: function(credentials) {
      var login = $http.post("/sessions/signin", sanitizeCredentials(credentials));
      login.success(cacheSession);
      login.success(FlashService.clear);
      login.error(loginError);
      return login;
    },
    logout: function() {
      var logout = $http.get("/sessions/signout");
      logout.success(uncacheSession);
      return logout;
    },
    isLoggedIn: function() {
      return SessionService.get('authenticated');
    }
  };
});

app.controller("LoginController", function($scope, $location, AuthenticationService) {
  $scope.credentials = {username: "", password: ""};

  $scope.login = function() {
    AuthenticationService.login($scope.credentials).success(function() {
      $location.path('/employees');
    });
  };

  $scope.logout = function() {
    AuthenticationService.logout().success(function() {
      $location.path('/login');
    });
  };
});

app.controller("EmployeesController", function($scope, employees) {
  $scope.employees = employees.data;
});
