import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final TextEditingController _certificatController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _employeeTypeController = TextEditingController();

  late mongo.DbCollection employeeCollection;

  @override
  void initState() {
    super.initState();
    // Establish a connection to the MongoDB database
    final db = mongo.Db('mongodb+srv://PFAY2Ai:MvqdYN84OGYYtO8D@pfa.clt7gyd.mongodb.net/');
    // Specify the collection name
    employeeCollection = db.collection('employees');
  }

  @override
  void dispose() {
    _certificatController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _addressController.dispose();
    _faxController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _employeeTypeController.dispose();
    super.dispose();
  }

  void _addEmployee() async {
    // Retrieve the entered values from the text controllers
    final String certificat = _certificatController.text;
    final String lastName = _lastNameController.text;
    final String firstName = _firstNameController.text;
    final String address = _addressController.text;
    final String fax = _faxController.text;
    final String email = _emailController.text;
    final String phone = _phoneController.text;
    final String employeeType = _employeeTypeController.text;

    // Create a document to be inserted into the collection
    final employeeDocument = {
      'certificat': certificat,
      'lastName': lastName,
      'firstName': firstName,
      'address': address,
      'fax': fax,
      'email': email,
      'phone': phone,
      'employeeType': employeeType,
    };

    try {
      // Insert the document into the collection
      await employeeCollection.insert(employeeDocument);

      // Clear the text fields after adding the employee
      _certificatController.clear();
      _lastNameController.clear();
      _firstNameController.clear();
      _addressController.clear();
      _faxController.clear();
      _emailController.clear();
      _phoneController.clear();
      _employeeTypeController.clear();

      // Show a success message or navigate back to the previous page
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Employee added successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Navigate back to the previous page
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Handle any errors that occurred during the database operation
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to add employee. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _certificatController,
              decoration: const InputDecoration(labelText: 'Certificat'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _faxController,
              decoration: const InputDecoration(labelText: 'Fax'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextFormField(
              controller: _employeeTypeController,
              decoration: const InputDecoration(labelText: 'Employee Type'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addEmployee,
              child: const Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
