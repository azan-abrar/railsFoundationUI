app.controller("DepartmentsController", function($scope, $location, DepartmentService, FlashService) {
  $scope.errorsAlert = false;
  $scope.nextPage = 1;
  $scope.prevPage = 1;
  $scope.departmentLabel = "Add";

  $scope.departmentModel = {name: "", id: "", description: ""};

  $scope.getDepartment = function() {
    DepartmentService.getDepartment().success(function(department) {
      $scope.departmentModel = department;
    }).error(function(response) {
      $location.path('/departments');
      setTimeout(function() {
        $scope.$apply(function() {
          FlashService.show(response.error);
        });
      }, 1000);
    });
  };

  $scope.editDepartment = function() {
    DepartmentService.editDepartment().success(function(department) {
      if (!department.id) {
        $scope.departmentLabel = "Add";
      } else {
        $scope.departmentLabel = "Edit";
      }
      $scope.departmentModel = department;
    }).error(function(response) {
      $location.path('/departments');
      setTimeout(function() {
        $scope.$apply(function() {
          FlashService.show(response.error);
        });
      }, 1000);

    });
  };

  $scope.getDepartments = function() {
    DepartmentService.getDepartments().success(function(departments_list) {
      FlashService.clear();
      $scope.departments = departments_list.departments;
      $scope.nextPage = departments_list.next_page;
      $scope.prevPage = departments_list.prev_page;
    }).error(function(response) {
      FlashService.show(response.error);
    });
  };

  $scope.updateDepartment = function() {
    DepartmentService.updateDepartment($scope.departmentModel).success(function(department) {
      $scope.departmentModel = department;
      $location.path('/department/' + $scope.departmentModel.id);
      $scope.errorsAlert = false;
    }).error(function(errors) {
      $scope.errors = errors;
      $scope.errorsAlert = true;
    });
  };

  $scope.removeDepartment = function(empId) {
    if ( window.confirm('Are you sure you want to delete this department?') ) {
      DepartmentService.deleteDepartment(empId).success(function(response) {
        $location.path('/departments');
        setTimeout(function() {
          $scope.$apply(function() {
            FlashService.show(response.success);
          });
        }, 1000);
      });
    }
  };


});
