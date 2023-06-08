import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Manager/employe/addEmployee.dart';
import 'package:flutter_application_1/screens/Manager/employe/deleteEmploye.dart';
import 'package:flutter_application_1/screens/Manager/employe/modifyEmployee.dart';

class ManageEmployee extends StatefulWidget {
  const ManageEmployee({Key? key}) : super(key: key);

  @override
  _ManageEmployeeState createState() => _ManageEmployeeState();
}

class _ManageEmployeeState extends State<ManageEmployee> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        title: const Text('Employee'),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Modify',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    // Render different pages based on the selected index
    switch (_selectedIndex) {
      case 0:
        return const AddEmployeePage(); // Replace with your Add Employee page
      case 1:
        return const ModifyEmployeePage(); // Replace with your Modify Employee page
      case 2:
        return const DeleteEmployeePage(); // Replace with your Delete Employee page
      default:
        return const AddEmployeePage();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
