app.controller("EmployeesController", function($scope, $location, EmployeeService, FlashService) {
  $scope.errorsAlert = false;
  $scope.searchField = "";
  $scope.employees = [];
  $scope.nextPage = 1;
  $scope.prevPage = 1;
  $scope.employeeLabel = "Add";
  $scope.employeeMaritalStatus = {false: "Single", true: "Married"};
  $scope.employeeStatus = {false: "Disabled", true: "Enabled"};
  $scope.employeeConstants = { countries: [], genders: [], status: [], marital_status: [], department_ids: [] }
  $scope.employeeModel = {gender: "", employee_id: "", full_name: "Employee Name", first_name: "", middle_name: "", last_name: "", email: "", designation: "", status: "", resume: "", dob: "", is_married: "", join_date: "", permanent_address: "", primary_state: "", permanent_city: "", permanent_postal_code: "", permanent_country_code: "", permanent_country_name: "", secondary_address: "", secondary_state: "", secondary_city: "", secondary_postal_code: "", secondary_country_code: "", secondary_country_name: "", mobile_phone: "", home_phone: "", department_id: "", department_name: "", resume_name: "", profile_picture_thumb: "", profile_picture_mini: ""};

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
        $scope.employeeConstants.genders = constantsArray.genders;
        $scope.employeeConstants.status = constantsArray.status;
        $scope.employeeConstants.marital_status = constantsArray.marital_status;
        $scope.employeeConstants.department_ids = constantsArray.department_ids;
        $scope.employeeConstants.countries = constantsArray.countries;
      });

    }).error(function(response) {
      $location.path('/employees');
      setTimeout(function() {
        $scope.$apply(function() {
          FlashService.show(response.error);
        });
        console.log('errors shown');
      }, 1000);
    });
  };

  $scope.getEmployees = function() {
    EmployeeService.getEmployees().success(function(employees_list) {
      FlashService.clear();
      $scope.employees = employees_list.employees;
      $scope.nextPage = employees_list.next_page;
      $scope.prevPage = employees_list.prev_page;
      $scope.isAdmin = employees_list.is_admin;
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
      setTimeout(function() {
        $(window).scrollTop($('.employee-form-errors').position().top);
      }, 500);
    });
  };

  $scope.removeEmployee = function(empId) {
    if ( window.confirm('Are you sure you want to delete this employee?') ) {
      EmployeeService.deleteEmployee(empId).success(function(response) {
        $location.path('/employees');
        setTimeout(function() {
          $scope.$apply(function() {
            FlashService.show(response.success);
          });
        }, 1000);
      });
    }
  };

  $scope.searchEmployees = function(page) {
    if ($location.path() !== "/employees") {
      $location.path('/employees');
    }
    var queryParam = $scope.searchField;
    if (!queryParam && !!$location.search()["query"]) {
      queryParam = $location.search()["query"];
    }
    if (page) {
      $location.search({page: page, query: queryParam});
    } else {
      $location.search({query: queryParam});
    }
  };


});
