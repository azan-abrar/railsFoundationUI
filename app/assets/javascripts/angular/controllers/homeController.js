app.controller("HomeController", function($scope, $location, HomeService) {
	$scope.companyLogo = "/assets/confiz-logo.png";

	$scope.initializeHomePage = function() {
    HomeService.getCompanyLogo().success(function(response) {
    	$scope.companyLogo = response.company_logo;
    });
  };

});
