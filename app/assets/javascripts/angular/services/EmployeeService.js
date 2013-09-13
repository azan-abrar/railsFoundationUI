app.factory("EmployeeService", function($http, $route, $location) {
  return {
    getEmployees: function() {
      var queryParam = $location.search()["query"];
      var pageParam = $location.search()["page"];
      if ( !queryParam ) { 
        queryParam = $route.current.params.query; 
      }
      if ( !pageParam ) { 
        pageParam = $route.current.params.page; 
      }
      
      if ( queryParam && pageParam ) {
        return $http.get('/employees', {params: {query: queryParam, page: pageParam}});
      } else if ( queryParam ) {
        return $http.get('/employees', {params: {query: queryParam}});
      } else if ( pageParam ) {
        return $http.get('/employees', {params: {page: pageParam}});
      } else {
        return $http.get('/employees');
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
      if (!$route.current.params.employeeID) {
        return $http.post('/employees', {employee: employeeParams});
      } else {
        return $http.put('/employees/' + $route.current.params.employeeID, {employee: employeeParams});
      }
    },
    deleteEmployee: function(empId) {
      return $http.delete('/employees/' + empId);
    },
    getEmployeeConstants: function() {
      return $http.get('/employees/get_employee_constants');
    }
  };
});
