class Contact {
  int id;
  String idAdresse;
  int fax;
  String mail;
  String fix;
  String phone;

  Contact({
    required this.id,
    required this.idAdresse,
    required this.fax,
    required this.mail,
    required this.fix,
    required this.phone,
  });

  // Getters
  int get getId => id;
  String get getIdAdresse => idAdresse;
  int get getFax => fax;
  String get getMail => mail;
  String get getFix => fix;
  String get getPhone => phone;

  // Setters
  set setId(int value) => id = value;
  set setIdAdresse(String value) => idAdresse = value;
  set setFax(int value) => fax = value;
  set setMail(String value) => mail = value;
  set setFix(String value) => fix = value;
  set setPhone(String value) => phone = value;
}
