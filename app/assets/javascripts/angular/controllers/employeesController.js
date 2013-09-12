app.controller("EmployeesController", function($scope, $location, EmployeeService, FlashService) {
  $scope.errorsAlert = false;
  $scope.searchField = "";
  $scope.employees = [];
  $scope.employeeLabel = "Add";
  $scope.employeeModel = {first_name: "", middle_name: "", last_name: "", email: "", designation: "", job_status: "", resume: "", dob: "", is_married: "", join_date: "", permanent_address: "", secondary_address: "", phone_1: "", phone_2: ""};

  $scope.getEmployee = function() {
    EmployeeService.getEmployee().success(function(employee) {
      $scope.employeeModel = employee;
    });
  };

  $scope.editEmployee = function() {
    EmployeeService.editEmployee().success(function(employee) {
      if (!employee.id) {
        $scope.employeeLabel = "Add";
      } else {
        $scope.employeeLabel = "Edit";
      }
      $scope.employeeModel = employee;
    });
  };

  $scope.getEmployees = function() {
    EmployeeService.getEmployees().success(function(employees) {
      FlashService.clear();
      $scope.employees = employees;
    }).error(function(response){
      FlashService.show(response.error);
    });
  };

  $scope.update = function() {
    EmployeeService.updateEmployee($scope.employeeModel).success(function(employee) {
      $scope.employeeModel = employee;
      $location.path('/employee/' + $scope.employeeModel.id);
      $scope.errorsAlert = false;
    }).error(function(errors) {
      $scope.errors = errors;
      $scope.errorsAlert = true;
    });
  };

  $scope.searchEmployees = function() {
    if ( $location.path() !== "/employees" ) {
      $location.path('/employees');
    }
    $location.search('query', $scope.searchField);
  };


});
