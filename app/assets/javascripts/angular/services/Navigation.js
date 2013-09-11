app.factory("Navigation", function($rootScope) {
  return {
    showNav: function() {
      $rootScope.showNavigationBar = true;
    },
    hideNav: function() {
      $rootScope.showNavigationBar = false;
    }
  }
});

