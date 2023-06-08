import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Manager/employe/manageEmploye.dart';
import 'package:flutter_application_1/screens/Manager/homes/Facture.dart';
import 'package:flutter_application_1/screens/Manager/homes/ProfilePage_manager.dart';
import 'package:flutter_application_1/screens/Manager/homes/homepage.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Manager extends StatefulWidget {
  const Manager({Key? key}) : super(key: key);

  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isSidebarOpen = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
      if (_isSidebarOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        // Navigate to ManageEmployee page when index is 1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ManageEmployee()),
        );
      }
    });
  }

  void _onItemTappedd(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        // Navigate to ManageEmployee page when index is 1
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ManageEmployee()),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _toggleSidebar,
        ),
        title: const Text('Manager'),
        actions: [
          GestureDetector(
            onTap: () {
              // Add your logout functionality here
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Icon(
                Icons.logout,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: const [
              Dashboard(),
              Profile(),
              Facture(),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width:
                  _isSidebarOpen ? MediaQuery.of(context).size.width * 0.6 : 0,
              color: Colors.grey[200],
              child: _isSidebarOpen
                  ? ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text(
                            'Menu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text('Clients'),
                          onTap: () {
                            // Add your sidebar item 1 functionality here
                          },
                        ),
                        ListTile(
                          title: const Text('Employees'),
                          onTap: () {
                            _onItemTapped(1); // Navigate to ManageEmployee page
                          },
                        ),
                        ListTile(
                          title: const Text('Services'),
                          onTap: () {
                            // Add your sidebar item 3 functionality here
                          },
                        ),
                      ],
                    )
                  : null,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: _selectedIndex,
        onTap: _onItemTappedd,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Facture',
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 24.0),
        curve: Curves.easeInOut,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.gps_fixed),
            label: 'GPS',
            onTap: () {
              // Add your GPS functionality here
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.calendar_today),
            label: 'Calendar',
            onTap: () {
              // Add your calendar functionality here
            },
          ),
        ],
      ),
    );
  }
}
