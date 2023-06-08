class Intervention {
  int id;
  String date;
  double quantite;
  String idManager;
  int idClient;

  Intervention({
    required this.id,
    required this.date,
    required this.quantite,
    required this.idManager,
    required this.idClient,
  });

  // Getters
  int get getId => id;
  String get getDate => date;
  double get getQuantite => quantite;
  String get getIdManager => idManager;
  int get getIdClient => idClient;

  // Setters
  set setId(int value) => id = value;
  set setDate(String value) => date = value;
  set setQuantite(double value) => quantite = value;
  set setIdManager(String value) => idManager = value;
  set setIdClient(int value) => idClient = value;

  factory Intervention.fromJson(Map<String, dynamic> json) {
        return Intervention(
          id: json['_id'],
          date: json['date'],
          quantite: json['quantite'],
          idManager: json['idManager'],
          idClient: json['idClient'],
        );
    }
      Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date,
      'quantite': quantite,
      'idManager': idManager,
      'idClient': idClient,
    };
  }

}
