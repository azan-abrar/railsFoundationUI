app.controller("EmployeesController", function($scope, employees, $location, EmployeeService) {
  $scope.employees = employees.data;

  $scope.create = function() {
    EmployeeService.create($scope.credentials).success(function() {
      $location.path('/employees/');
    });
  };

  $scope.update = function() {
    EmployeeService.logout().success(function() {
      $location.path('/login');
    });
  };
});
