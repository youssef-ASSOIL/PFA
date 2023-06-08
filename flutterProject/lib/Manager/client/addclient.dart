import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

const String MONGO_CONN_URL =
    "mongodb+srv://PFAY2Ai:MvqdYN84OGYYtO8D@pfa.clt7gyd.mongodb.net/WasteToxique?retryWrites=true&w=majority";

class Client {
  final String id;
  final String domaine;
  final String nomClient;
  final String prenomClient;
  final String nomEntreprise;
  final String idIntervention;
  final String idContact;
  final String idFacture;
  final String idCompte;

  Client({
    required this.id,
    required this.domaine,
    required this.nomClient,
    required this.prenomClient,
    required this.nomEntreprise,
    required this.idIntervention,
    required this.idContact,
    required this.idFacture,
    required this.idCompte,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Domaine': domaine,
      'NomClient': nomClient,
      'PrenomClient': prenomClient,
      'NomEntreprise': nomEntreprise,
      'idIntervention': idIntervention,
      'idcontact': idContact,
      'idFacture': idFacture,
      'idCompte': idCompte,
    };
  }
}

class AddClientPage extends StatefulWidget {
  const AddClientPage({Key? key}) : super(key: key);

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController domaineController = TextEditingController();
  TextEditingController nomClientController = TextEditingController();
  TextEditingController prenomClientController = TextEditingController();
  TextEditingController nomEntrepriseController = TextEditingController();
  TextEditingController idInterventionController = TextEditingController();
  TextEditingController idContactController = TextEditingController();
  TextEditingController idFactureController = TextEditingController();
  TextEditingController idCompteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: domaineController,
              decoration: InputDecoration(labelText: 'Domaine'),
            ),
            TextField(
              controller: nomClientController,
              decoration: InputDecoration(labelText: 'Nom Client'),
            ),
            TextField(
              controller: prenomClientController,
              decoration: InputDecoration(labelText: 'Prenom Client'),
            ),
            TextField(
              controller: nomEntrepriseController,
              decoration: InputDecoration(labelText: 'Nom Entreprise'),
            ),
            TextField(
              controller: idInterventionController,
              decoration: InputDecoration(labelText: 'ID Intervention'),
            ),
            TextField(
              controller: idContactController,
              decoration: InputDecoration(labelText: 'ID Contact'),
            ),
            TextField(
              controller: idFactureController,
              decoration: InputDecoration(labelText: 'ID Facture'),
            ),
            TextField(
              controller: idCompteController,
              decoration: InputDecoration(labelText: 'ID Compte'),
            ),
            ElevatedButton(
              onPressed: () {
                addClientToDatabase();
              },
              child: Text('Add Client to MongoDB'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addClientToDatabase() async {
    final id = idController.text;
    final client = Client(
      id: id,
      domaine: domaineController.text,
      nomClient: nomClientController.text,
      prenomClient: prenomClientController.text,
      nomEntreprise: nomEntrepriseController.text,
      idIntervention: idInterventionController.text,
      idContact: idContactController.text,
      idFacture: idFactureController.text,
      idCompte: idCompteController.text,
    );

    final db = await mongo.Db.create(MONGO_CONN_URL);
    await db.open();
    final collection = db.collection('Clients');

    final existingDocument =
        await collection.findOne(mongo.where.eq('_id', id));
    if (existingDocument != null) {
      // Document with the given ID already exists
      print('Document with ID $id already exists in the database.');
    }
    // else {
    //   // Check if the contact exists in the Contact collection
    //   final contactCollection = db.collection('Contact');
    //   final contactDocument = await contactCollection
    //       .findOne(mongo.where.eq('_id', client.idContact));
    //   if (contactDocument == null) {
    //     // Contact with the given ID doesn't exist
    //     print(
    //         'Contact with ID ${client.idContact} does not exist. Add the contact first.');
    //}
    else {
      await collection.insert(client.toJson());
      print('Client added to MongoDB successfully.');
    }
    //}

    await db.close();

    // Clear text fields after adding to the database
    // idController.clear();
    // dateController.clear();
    // domaineController.clear();
    // nomClientController.clear();
    // prenomClientController.clear();
    // nomEntrepriseController.clear();
    // idInterventionController.clear();
    // idContactController.clear();
    // idFactureController.clear();
    // idCompteController.clear();
  }
}
