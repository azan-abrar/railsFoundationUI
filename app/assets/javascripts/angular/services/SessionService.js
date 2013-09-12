app.factory("SessionService", function($cookieStore) {
  return {
    get: function(key) {
      return $cookieStore.get(key);
//      return sessionStorage.getItem(key);
    },
    set: function(key, val) {
      return $cookieStore.put(key, val);
//      return sessionStorage.setItem(key, val);
    },
    unset: function(key) {
      return $cookieStore.remove(key);
//      return sessionStorage.removeItem(key);
    }
  }
});
