app.factory("DepartmentService", function($http, $route) {
  return {
    getDepartments: function() {
      return $http.get('/departments');
    },
    getDepartment: function() {
      return $http.get('/departments/' + $route.current.params.departmentID);
    },
    editDepartment: function() {
      if (!$route.current.params.departmentID) {
        return $http.get('/departments/new');
      } else {
        return $http.get('/departments/' + $route.current.params.departmentID + '/edit');
      }
    },
    updateDepartment: function(departmentParams) {
      if (!$route.current.params.departmentID) {
        return $http.post('/departments', {department: departmentParams});
      } else {
        return $http.put('/departments/' + $route.current.params.departmentID, {department: departmentParams});
      }
    },
    deleteDepartment: function(depId) {
      return $http.delete('/departments/' + depId);
    }
  };
});
