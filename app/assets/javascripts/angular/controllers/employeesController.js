app.controller("EmployeesController", function($scope, $location, EmployeeService, FlashService) {
  $scope.errorsAlert = false;
  $scope.searchField = "";
  $scope.employees = [];
  $scope.employeeLabel = "Add";
  $scope.employeeConstants = {
    designations: [{name: '- Select Designation -', value: ''}],
    job_status: [{name: '- Select Job Status -', value: ''}],
    departments: [{name: '- Select Department -', value: ''}]
  }
  $scope.employeeModel = {first_name: "", middle_name: "", last_name: "", email: "", designation: "", job_status: "", resume: "", dob: "", is_married: "", join_date: "", permanent_address: "", permanent_city: "", permanent_postal_code: "", secondary_address: "", secondary_city: "", secondary_postal_code: "", mobile_phone: "", home_phone: "", department_id: "", department_name: ""};

  $scope.getEmployee = function() {
    EmployeeService.getEmployee().success(function(employee) {
      $scope.employeeModel = employee;
    }).error(function(response) {
      $location.path('/employees');
      setTimeout(function() {
        $scope.$apply(function() {
          FlashService.show(response.error);
        });
      }, 1000);
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

      EmployeeService.getEmployeeConstants().success(function(constantsArray) {
        $scope.employeeConstants.designations = constantsArray.designations;
        $scope.employeeConstants.job_status = constantsArray.job_status;
        $scope.employeeConstants.departments = constantsArray.departments;

//        $scope.employeeModel.designation = $scope.employeeConstants.designations[1];
//        $scope.employeeModel.job_status = $scope.employeeConstants.job_status[1];
//        $scope.employeeModel.department_id = $scope.employeeConstants.departments[2];

      });

    }).error(function(response) {
      $location.path('/employees');
      setTimeout(function() {
        $scope.$apply(function() {
          FlashService.show(response.error);
        });
      }, 1000);

    });
  };

  $scope.getEmployees = function() {
    EmployeeService.getEmployees().success(function(employees) {
      FlashService.clear();
      $scope.employees = employees;
    }).error(function(response) {
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
    if ($location.path() !== "/employees") {
      $location.path('/employees');
    }
    $location.search('query', $scope.searchField);
  };


});
