

abstract class BasePreference<T> {
  void setUserLoggedIn(bool value) {}

  bool isUserLoggedIn() {
    throw UnimplementedError();
  }

  void setUserId(String userId) {}

  String getUserId() {
    throw UnimplementedError();
  }
   void saveLanguageCode(bool userId) {}

  bool getLanguageCode() {
    throw UnimplementedError();
  }


  // Future<LoginResponse?> getUser() {
  //   throw UnimplementedError();
  // }

  // Future setUser(LoginResponse loginResponse) {
  //   throw UnimplementedError();
  // }

  

  Future<void> clearStorage() {
    throw UnimplementedError();
  }
}
