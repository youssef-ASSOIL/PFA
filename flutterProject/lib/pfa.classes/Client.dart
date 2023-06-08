import 'package:flutter_application_1/pfa.classes/Compte.dart';

class Client {
   int _id;
  String? _date;
  String? _domaine;
  String? _nomClient;
  String? _prenomClient;
  String? _nomEntreprise;
  int? _idIntervention;
  int? _idContact;
  int? _idFacture;
  Compte? _compte;

  Client({
    required String id,
    String? date,
    String? domaine,
    String? nomClient,
    String? prenomClient,
    String? nomEntreprise,
    String? idIntervention,
    String? idContact,
    String? idFacture,
    Compte? compte,
  })   : _id = int.parse(id),
        _date = date,
        _domaine = domaine,
        _nomClient = nomClient,
        _prenomClient = prenomClient,
        _nomEntreprise = nomEntreprise,
        _idIntervention = idIntervention != null ? int.parse(idIntervention) : null,
        _idContact = idContact != null ? int.parse(idContact) : null,
        _idFacture = idFacture != null ? int.parse(idFacture) : null,
        _compte = compte;

  int get id => _id;
  set id(int value) => _id = value;

  String? get date => _date;
  set date(String? value) => _date = value;

  String? get domaine => _domaine;
  set domaine(String? value) => _domaine = value;

  String? get nomClient => _nomClient;
  set nomClient(String? value) => _nomClient = value;

  String? get prenomClient => _prenomClient;
  set prenomClient(String? value) => _prenomClient = value;

  String? get nomEntreprise => _nomEntreprise;
  set nomEntreprise(String? value) => _nomEntreprise = value;

  int? get idIntervention => _idIntervention;
  set idIntervention(int? value) => _idIntervention = value;

  int? get idContact => _idContact;
  set idContact(int? value) => _idContact = value;

  int? get idFacture => _idFacture;
  set idFacture(int? value) => _idFacture = value;

  Compte? get compte => _compte;
  set compte(Compte? value) => _compte = value;
  

   factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'].toString(),
      date: map['date'],
      domaine: map['domaine'],
      nomClient: map['nomClient'],
      prenomClient: map['prenomClient'],
      nomEntreprise: map['nomEntreprise'],
      idIntervention: map['idIntervention'].toString(),
      idContact: map['idContact'].toString(),
      idFacture: map['idFacture'].toString(),
      compte: Compte.fromMap(map['compte']),
    );
  }
 
}


