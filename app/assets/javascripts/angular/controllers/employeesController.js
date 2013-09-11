app.controller("EmployeesController", function($scope, $location, EmployeeService) {
  $scope.errorsAlert = false;

  $scope.getEmployee = function() {
    EmployeeService.getEmployee().success(function(employee) {
      $scope.employee = employee;
    });
  };
  
  $scope.employees = function() {
    EmployeeService.get().success(function(employees) {
      $scope.employees = employees;
    });
  };

  $scope.create = function() {
    EmployeeService.createEmployee().success(function(employee) {
      debugger
      $scope.employee = employee;
      $location.path('/employees/' + $scope.employee.id);
      $scope.errorsAlert = false;
    }).error(function(errors) {
      $scope.errors = errors;
      $scope.errorsAlert = true;
    });
  };

  $scope.update = function() {
    EmployeeService.updateEmployee().success(function() {
      $location.path('/login');
    });
  };
});
