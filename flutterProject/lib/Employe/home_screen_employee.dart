import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Employee extends StatefulWidget {
  const Employee({Key? key}) : super(key: key);

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  List<Task> tasks = [
    Task(name: "Task 1", isCompleted: false),
    Task(name: "Task 2", isCompleted: true),
    Task(name: "Task 3", isCompleted: false),
  ];

  bool isSidebarOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            setState(() {
              isSidebarOpen = !isSidebarOpen;
            });
          },
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskBox(
                task: tasks[index],
                onTaskCompleted: () {
                  setState(() {
                    tasks[index].isCompleted = true;
                  });
                },
              );
            },
          ),
          if (isSidebarOpen)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Sidebar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Option 1'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Option 2'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Random Item 1'),
                      onTap: () {
                        Navigator.pop(context);
                        // Perform desired action
                      },
                    ),
                    ListTile(
                      title: const Text('Random Item 2'),
                      onTap: () {
                        Navigator.pop(context);
                        // Perform desired action
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.perm_contact_cal_outlined),
            label: "Calendar",
          ),
          SpeedDialChild(
            child: const Icon(Icons.gps_fixed),
            label: "GPS",
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                debugPrint("Tap");
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                    ),
                    Text("Home"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Tip");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilPage()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                    ),
                    Text("Profile"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskBox extends StatefulWidget {
  final Task task;
  final Function onTaskCompleted;

  const TaskBox({required this.task, required this.onTaskCompleted, Key? key})
      : super(key: key);

  @override
  _TaskBoxState createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = ColorTween(begin: Colors.transparent, end: Colors.green)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.task.isCompleted) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.task.isCompleted = !widget.task.isCompleted;
        });
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            height: 100,
            color: _animation.value,
            child: Center(
              child: Text(
                widget.task.name,
                style: TextStyle(
                  color: widget.task.isCompleted ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: const Center(
        child: Text('This is the profile page'),
      ),
    );
  }
}
