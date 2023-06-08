import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

const String MONGO_CONN_URL =
    "mongodb+srv://PFAY2Ai:MvqdYN84OGYYtO8D@pfa.clt7gyd.mongodb.net/WasteToxique?retryWrites=true&w=majority";

class ClientDetailsPage extends StatefulWidget {
  final Map<String, dynamic> client;

  const ClientDetailsPage({Key? key, required this.client}) : super(key: key);

  @override
  _ClientDetailsPageState createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  Map<String, dynamic>? contactData;
  bool isLoading = true;
  String? searchId;

  @override
  void initState() {
    super.initState();
    searchId = widget.client['idcontact'].toString(); // Convert to String
    print('Searching for idcontact: $searchId');
    fetchContactData();
  }

  void fetchContactData() async {
    try {
      final db = await mongo.Db.create(MONGO_CONN_URL);
      await db.open();

      final contactCollection = db.collection('Contact');

      final fetchedContactData =
          await contactCollection.findOne(mongo.where.eq('_id', searchId));

      print('Fetched contact data: $fetchedContactData');

      setState(() {
        contactData = fetchedContactData;
        isLoading = false;
      });

      db.close();
    } catch (error) {
      print('Error fetching contact data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.client['NomClient']} ${widget.client['PrenomClient']}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Client ID:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.client['_id']}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            SizedBox(height: 16),
            Text(
              'Domaine:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.client['Domaine']}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Company Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.client['NomEntreprise']}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Details:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            isLoading
                ? CircularProgressIndicator()
                : contactData != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(
                              'region',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${contactData!['region']}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(
                              'rue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${contactData!['rue']}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_city),
                            title: Text(
                              'ville',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${contactData!['ville']}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'No contact details found.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
