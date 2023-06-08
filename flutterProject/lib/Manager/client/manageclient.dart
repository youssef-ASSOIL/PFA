import 'package:flutter/material.dart';
import 'package:flutter_application_1/Manager/client/addclient.dart';
import 'package:flutter_application_1/Manager/client/listclient.dart';
import 'package:flutter_application_1/Manager/employe/listemployee.dart';

class ManageClient extends StatefulWidget {
  const ManageClient({Key? key}) : super(key: key);

  @override
  _ManageClientState createState() => _ManageClientState();
}

class _ManageClientState extends State<ManageClient> {
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
        title: const Text('Client'),
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
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1_rounded),
            label: 'Add',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    // Render different pages based on the selected index
    switch (_selectedIndex) {
      case 0:
        return const ListClientPage(); // Replace with your Add Employee page
      case 1:
        return const AddClientPage(); // Replace with your Modify Employee page
      default:
        return const ListEmployePage();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
