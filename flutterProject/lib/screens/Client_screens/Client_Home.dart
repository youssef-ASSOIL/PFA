import 'package:flutter/material.dart';
import 'package:flutter_application_1/pfa.classes/Intervention.dart';
import 'package:flutter_application_1/screens/Dechets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../connectionDb/connection.dart';


class ClientMenu extends StatefulWidget {
  final String idClient;
  const ClientMenu({Key? key, required this.idClient}) : super(key: key);
  @override
  _ClientMenuState createState() => _ClientMenuState(idClient: idClient);
}

class _ClientMenuState extends State<ClientMenu> {
 final String idClient;
  
  _ClientMenuState({required this.idClient});

  int _selectedIndex = 0;
  late List<Widget> _pages;
   
  

 

  @override
  void initState() {
    super.initState();
    _pages = [
      CalendarScreen(idClient:int.parse(idClient)),
      PageIntervention(idClient: int.parse(idClient)),
      PersonalInformationScreen(idClient: widget.idClient),
    ];
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon:  Container(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        './images/home.png',
                        fit: BoxFit.contain,
                      ),
                    ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:Container(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        './images/add.png',
                        fit: BoxFit.contain,
                      ),
                    ),
            label: 'Add Intervontion',
          ),
          BottomNavigationBarItem(
            icon: Container(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        './images/user.png',
                        fit: BoxFit.contain,
                      ),
                    ),
            label: 'PersonalInformation',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  const PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

class PageIntervention extends StatefulWidget {
  final int idClient;

  PageIntervention({required this.idClient});
  @override
  _PageInterventionState createState() => _PageInterventionState(idClient: idClient);
}

class _PageInterventionState extends State<PageIntervention> {
  final int idClient;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Dechets? selectedWasteType;
_PageInterventionState({required this.idClient});

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          selectedTime = pickedTime;
        });
      }
    }
  }
TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB8E6D7),
              Color(0xFF397367),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Title info d\'intervention',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent[300],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Type de déchet',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<Dechets>(
                  value: selectedWasteType,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (Dechets? newValue) {
                    setState(() {
                      selectedWasteType = newValue;
                    });
                  },
                  items: Dechets.values.map<DropdownMenuItem<Dechets>>(
                    (Dechets value) {
                      return DropdownMenuItem<Dechets>(
                        value: value,
                        child: Text(
                          value.toString().split('.').last,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Quantity',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: quantityController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter the quantity',
                    hintStyle: TextStyle(color: Colors.white70),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Date and Hour',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: _selectDateTime,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: selectedDate != null && selectedTime != null
                      ? Text(
                          '${selectedDate!.toString().substring(0, 10)}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      : Text(
                          'Select Date and Hour',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                   onPressed: () {
  if (selectedWasteType != null && selectedDate != null) {
    // Retrieve the quantity from the TextField
                String quantity = quantityController.text; // Replace textFieldController with the actual TextEditingController for your TextField

                // Check if the quantity is not empty
                if (quantity.isNotEmpty) {
                  // Use the idClient variable in the Intervention constructor
                  Intervention intervention = Intervention(
                    id: 1,
                    date: selectedDate.toString(),
                    quantite: double.parse(quantity),
                    idManager: 'M000001',
                    idClient: idClient,
                  );

                  // Call the addIntervention method
                  addIntervention(intervention);
                } else {
                  // Handle the case when the quantity is empty
                  print('Quantity is empty. Please enter a valid value.');
                }
              }
            },

                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ),
                    child: Text(
                      'Confirmer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle cancel button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ),
                    child: Text(
                      'Annuler',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  final int idClient;

  CalendarScreen({required this.idClient});

  @override
  _CalendarScreenState createState() => _CalendarScreenState(idClient: idClient);
}

class _CalendarScreenState extends State<CalendarScreen> {
  final int idClient;
  List<DateTime> interventionDates = [];

  _CalendarScreenState({required this.idClient});

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Future<void> _fetchInterventionDates() async {
    List<DateTime> dates = await getInterventionDatesByClientId(idClient.toString());
    setState(() {
      interventionDates = dates;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  List<String> _getTasksForDay(DateTime day) {
    return _tasks[day] ?? [];
  }

  Map<DateTime, List<String>> _tasks = {
    DateTime(2023, 5, 31): ['Task 1', 'Task 2'],
    DateTime(2023, 6, 1): ['Task 3'],
    DateTime(2023, 6, 3): ['Task 4', 'Task 5'],
  };

  @override
  void initState() {
    super.initState();
    _fetchInterventionDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB8E6D7),
              Color(0xFF397367),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now().subtract(Duration(days: 365)),
              lastDay: DateTime.now().add(Duration(days: 365)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              availableCalendarFormats: {
                CalendarFormat.month: 'Month',
                CalendarFormat.week: 'Week',
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (interventionDates.contains(date)) {
                    return Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        width: 6,
                        height: 6,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tasks for ${_selectedDay.day}-${_selectedDay.month}-${_selectedDay.year}:',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _getTasksForDay(_selectedDay).length,
                itemBuilder: (context, index) {
                  final task = _getTasksForDay(_selectedDay)[index];
                  return ListTile(
                    title: Text(task),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalInformationScreen extends StatelessWidget {
  final String idClient;

  PersonalInformationScreen({required this.idClient});
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: buildAppBar(context),
    body: FutureBuilder<List<Map<String, dynamic>>?>(
      future: GestionClient().connectToMongoDB(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final fetchedClients = snapshot.data;
          final client = fetchedClients?.firstWhere(
            (client) => client['_id'].toString() == idClient,
            orElse: () => {},
          );
          if (client != null && client.isNotEmpty) {
            return buildPersonalInformation(client);
          } else {
            return Center(child: Text('Client not found.'));
          }
        }
      },
    ),
  );
}


  Widget buildPersonalInformation(Map<String, dynamic> client) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.0),
      children: [
        ProfileWidget(),
        SizedBox(height: 24.0),
        buildNameTile('Client Name', client['NomClient'] ?? 'N/A'),
        buildNameTile('Company Name', client['NomEntreprise'] ?? 'N/A'),
        buildNameTile('ID', client['_id'].toString()),
        buildNameTile('Type of Waste', client['Domaine'] ?? 'N/A'),
        SizedBox(height: 24.0),
        buildDescription(
          'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Client Information',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget buildNameTile(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget buildDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 64.0,
            backgroundImage: AssetImage('./images/user.png'),
          ),
          buildEditIcon(),
        ],
      ),
    );
  }

  Widget buildEditIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.edit,
        color: Colors.black,
        size: 20.0,
      ),
    );
  }
}