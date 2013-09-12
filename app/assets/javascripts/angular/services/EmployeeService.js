app.factory("EmployeeService", function($http, $route, $location) {
  return {
    getEmployees: function() {
      if (!$location.search()["query"]) {
        return $http.get('/employees');
      } else {
        return $http.get('/employees', { params: { query: $location.search()["query"] }});
      }
    },
    getEmployee: function() {
      return $http.get('/employees/' + $route.current.params.employeeID);
    },
    editEmployee: function() {
      if (!$route.current.params.employeeID) {
        return $http.get('/employees/new');
      } else {
        return $http.get('/employees/' + $route.current.params.employeeID + '/edit');
      }
    },
    updateEmployee: function(employeeParams) {
      if ( !$route.current.params.employeeID ) {
        return $http.post('/employees', {employee: employeeParams});
      } else {
        return $http.put('/employees/' + $route.current.params.employeeID, {employee: employeeParams});
      }
    },
    deleteEmployee: function() {
      return $http.delete('/employees/' + $route.current.params.employeeID);
    }
  };
});
