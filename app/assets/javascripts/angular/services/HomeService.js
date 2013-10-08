app.factory("HomeService", function($http) {

  return {
    getCompanyLogo: function() {
      return $http.get("/company_logo");
    }
  };

});
