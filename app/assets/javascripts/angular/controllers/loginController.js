app.controller("LoginController", function($scope, $location, AuthenticationService) {
  $scope.credentials = {username: "", password: ""};

  $scope.login = function() {
    AuthenticationService.login($scope.credentials).success(function() {
      //$location.path('/employees');
      location.href = "/";
    });
  };

  $scope.logout = function() {
    AuthenticationService.logout().success(function() {
      $location.path('/login');
    });
  };
});
