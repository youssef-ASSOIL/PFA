import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

const String MONGO_CONN_URL =
    "mongodb+srv://PFAY2Ai:MvqdYN84OGYYtO8D@pfa.clt7gyd.mongodb.net/WasteToxique?retryWrites=true&w=majority";

class Employee {
  final String id;
  final String certificat;
  final String nom;
  final String prenom;
  final String idContact;
  final String typeEmployee;

  Employee({
    required this.id,
    required this.certificat,
    required this.nom,
    required this.prenom,
    required this.idContact,
    required this.typeEmployee,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'certificat': certificat,
      'nom': nom,
      'prenom': prenom,
      'id_contact': idContact,
      'typeEmployee': typeEmployee,
    };
  }
}

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  TextEditingController idController = TextEditingController();
  TextEditingController certificatController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController idContactController = TextEditingController();
  TextEditingController typeEmployeeController = TextEditingController();

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
              controller: certificatController,
              decoration: InputDecoration(labelText: 'Certificat'),
            ),
            TextField(
              controller: nomController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: prenomController,
              decoration: InputDecoration(labelText: 'Prenom'),
            ),
            TextField(
              controller: idContactController,
              decoration: InputDecoration(labelText: 'ID Contact'),
            ),
            TextField(
              controller: typeEmployeeController,
              decoration: InputDecoration(labelText: 'Type Employee'),
            ),
            ElevatedButton(
              onPressed: () {
                addEmployeeToDatabase();
              },
              child: Text('Add Employee to MongoDB'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addEmployeeToDatabase() async {
    final id = idController.text;
    final employee = Employee(
      id: id,
      certificat: certificatController.text,
      nom: nomController.text,
      prenom: prenomController.text,
      idContact: idContactController.text,
      typeEmployee: typeEmployeeController.text,
    );

    final db = await mongo.Db.create(MONGO_CONN_URL);
    await db.open();
    final collection = db.collection('Employees');

    final existingDocument = await collection.findOne(mongo.where.eq('_id', id));
    if (existingDocument != null) {
      // Document with the given ID already exists
      print('Document with ID $id already exists in the database.');
    } else {
      await collection.insert(employee.toJson());
      print('Employee added to MongoDB successfully.');
    }

    await db.close();

    // Clear text fields after adding to the database
    idController.clear();
    certificatController.clear();
    nomController.clear();
    prenomController.clear();
    idContactController.clear();
    typeEmployeeController.clear();
  }
}
