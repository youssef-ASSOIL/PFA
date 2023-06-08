class Compte {
  int id;
  String login;
  String password;

  Compte({
    required this.id,
    required this.login,
    required this.password,
  });

  // Getters
  int get getId => id;
  String get getLogin => login;
  String get getPassword => password;

  // Setters
  set setId(int value) => id = value;
  set setLogin(String value) => login = value;
  set setPassword(String value) => password = value;
  factory Compte.fromMap(Map<String, dynamic> map) {
    return Compte(
      id: map['id'],
      login: map['login'],
      password: map['password'],
    );
  }
}
