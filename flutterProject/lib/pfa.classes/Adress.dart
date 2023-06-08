class Adresse {
  String id;
  int numero;
  String region;
  String rue;
  String ville;

  Adresse({
    required this.id,
    required this.numero,
    required this.region,
    required this.rue,
    required this.ville,
  });

  // Getters
  String get getId => id;
  int get getNumero => numero;
  String get getRegion => region;
  String get getRue => rue;
  String get getVille => ville;

  // Setters
  set setId(String value) => id = value;
  set setNumero(int value) => numero = value;
  set setRegion(String value) => region = value;
  set setRue(String value) => rue = value;
  set setVille(String value) => ville = value;
}
