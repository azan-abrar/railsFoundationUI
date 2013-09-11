app.factory("EmployeeService", function($http, $route) {
  return {
    get: function() {
      return $http.get('/employees');
    },
    getEmployee: function() {
      return $http.get('/employees/' + $route.current.params.employeeID);

    },
    createEmployee: function() {
      return $http.post('/employees');

    },
    updateEmployee: function() {
      return $http.put('/employees/' + $route.current.params.employeeID);

    },
    deleteEmployee: function() {
      return $http.delete('/employees/' + $route.current.params.employeeID);

    }
  };
});
