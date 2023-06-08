import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

const String MONGO_CONN_URL =
    "mongodb+srv://PFAY2Ai:MvqdYN84OGYYtO8D@pfa.clt7gyd.mongodb.net/WasteToxique?retryWrites=true&w=majority";

class EmployeeDetailsPage extends StatefulWidget {
  final Map<String, dynamic> employee;

  const EmployeeDetailsPage({Key? key, required this.employee})
      : super(key: key);

  @override
  _EmployeeDetailsPageState createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  Map<String, dynamic>? contactData;
  Map<String, dynamic>? adresseData;
  bool isLoading = true;
  int? searchId;

  @override
  void initState() {
    super.initState();
    searchId = widget.employee['id_contact'];
    print('Searching for id_contact: $searchId');
    fetchContactData();
  }

  void fetchContactData() async {
    try {
      final db = await mongo.Db.create(MONGO_CONN_URL);
      await db.open();

      final contactCollection = db.collection('Contact');
      final adresseCollection = db.collection('Adresse');

      final fetchedContactData =
          await contactCollection.findOne(mongo.where.eq('_id', searchId));

      if (fetchedContactData != null) {
        final idAdresse = fetchedContactData['idadress'];
        final fetchedAdresseData =
            await adresseCollection.findOne(mongo.where.eq('_id', idAdresse));

        setState(() {
          contactData = fetchedContactData;
          adresseData = fetchedAdresseData;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }

      db.close();
    } catch (error) {
      print('Error fetching contact data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
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
              '${widget.employee['nom']} ${widget.employee['prenom']}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Employee ID:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.employee['_id']}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Certificat:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.employee['certificat']}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Type Employee:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.employee['typeEmployee']}',
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
                            leading: Icon(Icons.email),
                            title: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${contactData!['mail']}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(
                              'Phone',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${contactData!['phone']}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          adresseData != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Numero',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${adresseData!['numero']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Region',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${adresseData!['region']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Rue',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${adresseData!['rue']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Ville',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${adresseData!['ville']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'No address details found.',
                                  style: TextStyle(
                                    fontSize: 16,
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
