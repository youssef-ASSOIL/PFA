class Camion {
  String id;
  int idEmploye;

  Camion({
    required this.id,
    required this.idEmploye,
  });

  // Getters
  String get getId => id;
  int get getIdEmploye => idEmploye;

  // Setters
  set setId(String value) => id = value;
  set setIdEmploye(int value) => idEmploye = value;
}
