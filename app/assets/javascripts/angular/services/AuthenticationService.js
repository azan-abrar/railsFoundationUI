app.factory("AuthenticationService", function($http, $sanitize, SessionService, FlashService) {

  var cacheSession = function() {
    SessionService.set('authenticated', true);
  };

  var uncacheSession = function(credentials) {
    credentials.username = '';
    credentials.password = '';
    SessionService.unset('authenticated');
  };

  var loginError = function(response) {
    FlashService.show(response.flash);
  };

  var sanitizeCredentials = function(credentials) {
    return {
      username: $sanitize(credentials.username),
      password: $sanitize(credentials.password)
    };
  };

  return {
    login: function(credentials) {
      var login = $http.post("/sessions/signin", sanitizeCredentials(credentials));
      login.success(FlashService.clear);
      login.error(loginError);
      return login;
    },
    logout: function() {
      var logout = $http.get("/sessions/signout");
      return logout;
    },
    isLoggedIn: function() {
      return $http.get("/sessions/is_logged_in");
    }
  };
});
