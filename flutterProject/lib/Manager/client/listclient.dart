import 'package:flutter/material.dart';
import 'package:flutter_application_1/Manager/client/listviewclient.dart';

import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: constant_identifier_names
const String MONGO_CONN_URL =
    "mongodb+srv://PFAY2Ai:MvqdYN84OGYYtO8D@pfa.clt7gyd.mongodb.net/WasteToxique?retryWrites=true&w=majority";
// ignore: constant_identifier_names
const String CLIENT_COLLECTION = "Client";

class ListClientPage extends StatefulWidget {
  const ListClientPage({Key? key}) : super(key: key);

  @override
  _ListClientPageState createState() => _ListClientPageState();
}

class _ListClientPageState extends State<ListClientPage> {
  List<Map<String, dynamic>> clients = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    connectToMongoDB();
  }

  void connectToMongoDB() async {
    try {
      final db = await mongo.Db.create(MONGO_CONN_URL);
      await db.open();

      final collection = db.collection(CLIENT_COLLECTION);

      final fetchedClients = await collection.find().toList();

      setState(() {
        clients = fetchedClients.map((client) => client).toList();
        isLoading = false;
      });

      db.close();
    } catch (error) {
      print('Error connecting to MongoDB: $error');
    }
  }

  Future<void> deleteClient(String id) async {
    final db = await mongo.Db.create(MONGO_CONN_URL);
    await db.open();
    final collection = db.collection(CLIENT_COLLECTION);

    final deleteResult =
        await collection.remove(mongo.where.eq('_id', int.parse(id)));
    if (deleteResult['n'] == 0) {
      // No document with the given ID found
      print('Client with ID $id does not exist in the database.');
    } else {
      print('Client with ID $id deleted successfully.');
      setState(() {
        clients.removeWhere((client) => client['_id'] == id);
      });
    }

    await db.close();
  }

  void navigateToClientDetailsPage(Map<String, dynamic> client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientDetailsPage(client: client),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];

                return Dismissible(
                  key: Key(client['_id'].toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    deleteClient(client['_id'].toString());
                    setState(() {
                      clients.removeAt(index);
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      navigateToClientDetailsPage(client);
                    },
                    child: ListTile(
                      title: Text(
                        client['NomClient'].toString() +
                            ' ' +
                            client['PrenomClient'].toString(),
                      ),
                      subtitle: Text(client['_id'].toString()),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
