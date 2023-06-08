import 'package:flutter/material.dart';
import 'package:flutter_application_1/Manager/employe/view1employe.dart';

import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: constant_identifier_names
const String MONGO_CONN_URL =
    "mongodb+srv://PFAY2Ai:MvqdYN84OGYYtO8D@pfa.clt7gyd.mongodb.net/WasteToxique?retryWrites=true&w=majority";
// ignore: constant_identifier_names
const String EMPLOYEE_COLLECTION = "Employees";

class ListEmployePage extends StatefulWidget {
  const ListEmployePage({Key? key}) : super(key: key);

  @override
  _ListEmployePageState createState() => _ListEmployePageState();
}

class _ListEmployePageState extends State<ListEmployePage> {
  List<Map<String, dynamic>> employees = [];
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

      final collection = db.collection(EMPLOYEE_COLLECTION);

      final fetchedEmployees = await collection.find().toList();

      setState(() {
        employees = fetchedEmployees.map((employee) => employee).toList();
        isLoading = false;
      });

      db.close();
    } catch (error) {
      print('Error connecting to MongoDB: $error');
    }
  }

  Future<void> deleteEmployee(dynamic id) async {
    final db = await mongo.Db.create(MONGO_CONN_URL);
    await db.open();
    final collection = db.collection(EMPLOYEE_COLLECTION);

    final deleteResult = await collection.remove(mongo.where.eq('_id', id));
    if (deleteResult['n'] == 0) {
      // No document with the given ID found
      print('Employee with ID $id does not exist in the database.');
    } else {
      print('Employee with ID $id deleted successfully.');
      setState(() {
        employees.removeWhere((employee) => employee['_id'] == id);
      });
    }

    await db.close();
  }

  void navigateToEmployeeDetailsPage(Map<String, dynamic> employee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeDetailsPage(employee: employee),
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
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];

                return Dismissible(
                  key: Key(employee['_id'].toString()),
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
                    deleteEmployee(employee['_id']);
                  },
                  child: GestureDetector(
                    onTap: () {
                      navigateToEmployeeDetailsPage(employee);
                    },
                    child: ListTile(
                      title: Text(
                        employee['nom'].toString() +
                            ' ' +
                            employee['prenom'].toString(),
                      ),
                      subtitle: Text(employee['_id'].toString()),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
