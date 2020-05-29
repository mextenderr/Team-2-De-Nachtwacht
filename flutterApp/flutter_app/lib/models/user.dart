class User {
  String uid;
  User._privateConstructor();

  static final User _instance = User._privateConstructor();

  factory User() {
    return _instance;
  }

}