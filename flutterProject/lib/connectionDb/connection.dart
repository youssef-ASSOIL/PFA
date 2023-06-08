import 'package:flutter_application_1/pfa.classes/Intervention.dart';
import 'package:mongo_dart/mongo_dart.dart';

const String MONGO_CONN_URL =
    "mongodb+srv://PFAY2Ai:MvqdYN84OGYYtO8D@pfa.clt7gyd.mongodb.net/WasteToxique?retryWrites=true&w=majority";
String USER_COLLECTION = "Client";
String COMPTE_COLLECTION = "Compte";
String INTERVENTION_COLLECTION = "Intervention";

class GestionClient {
  Future<List<Map<String, dynamic>>> connectToMongoDB() async {
    try {
      final db = await Db.create(MONGO_CONN_URL);
      await db.open();

      final collection = db.collection(USER_COLLECTION);

      final fetchedClients = await collection.find().toList();

      db.close();

      return fetchedClients;
    } catch (error) {
      print('Error connecting to MongoDB: $error');
      return [];
    }
  }
}

Future<Map<String, dynamic>?> fetchCompteById(int id) async {
  final db = await Db.create(MONGO_CONN_URL);
  await db.open();

  final collection = db.collection(COMPTE_COLLECTION);

  final compteDocument = await collection.findOne(where.eq('_id', id));

  db.close();

  return compteDocument;
}
 Future<Map<String, dynamic>?> fetchClientById(String id) async {
      final db = await Db.create(MONGO_CONN_URL);
      await db.open();

      final collection = db.collection(USER_COLLECTION);

      final clientDocument = await collection.findOne(where.eq('_id', id));

      db.close();

      return clientDocument;
    }


    Future<void> addIntervention(Intervention intervention) async {
    final db = await Db.create(MONGO_CONN_URL);
    await db.open();

    final collection = db.collection(INTERVENTION_COLLECTION);
    await collection.insert(intervention.toJson());

    db.close();

    print('Intervention added to collection.');
  }
  Future<List<DateTime>> getInterventionDatesByClientId(String idClient) async {
  final db = await Db.create(MONGO_CONN_URL);
  await db.open();

  final collection = db.collection(INTERVENTION_COLLECTION);
  final results = await collection
      .find(where.eq('idClient', int.parse(idClient)))
      .toList();

  db.close();

  // Extract and parse the dates from the intervention results
  final dates = results.map((intervention) {
    final dateString = intervention['date'];
    return DateTime.parse(dateString);
  }).toList();

  for (var i = 0; i < dates.length; i++) {
    print(dates[i].day);
    print(dates[i].year);
    print(dates[i].month);
  }
  
  return dates;

}

void main() async {
  // Create an instance of GestionClient
  GestionClient gestionClient = GestionClient();

  // Connect to MongoDB and retrieve the clients
  List<Map<String, dynamic>> fetchedClients = await gestionClient.connectToMongoDB();

  Future<void> printCompteProperties(int id) async {
    final compte = await fetchCompteById(id);

    if (compte != null) {
      print('Compte Properties for ID: $id');
      print('Login: ${compte['login']}');
      print('Password: ${compte['password']}');
    } else {
      print('Compte with ID $id not found.');
    }
  }

  // Print the clients
  fetchedClients.forEach((client) async {
    print('Client ID: ${client['_id'].toString()}');
    print('Date: ${client['date'] ?? 'N/A'}');
    print('Domaine: ${client['Domaine'] ?? 'N/A'}');
    print('Nom: ${client['NomClient'] ?? 'N/A'}');
    print('Prenom: ${client['PrenomClient'] ?? 'N/A'}');
    print('Nom Entreprise: ${client['NomEntreprise'] ?? 'N/A'}');
    print('ID Intervention: ${client['idIntervention'] ?? 'N/A'}');
    print('ID Contact: ${client['idcontact'] ?? 'N/A'}');
    print('ID Facture: ${client['idFacture'] ?? 'N/A'}');

    // Retrieve and display Compte properties if available
    if (client['idCompte'] != null) {
      final idCompte = client['idCompte'];
      printCompteProperties(idCompte);
    }
    print('-------------------------------');
  });

   

}
