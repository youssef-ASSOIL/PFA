import 'package:flutter/material.dart';

class MainTrackerPage extends StatefulWidget {
  const MainTrackerPage({super.key});

  @override
  State<MainTrackerPage> createState() => _MainTrackerPageState();
}

class _MainTrackerPageState extends State<MainTrackerPage> {
  bool isSwitch = false;
  bool? isCheckbox = false; //? it can be nulable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manager"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint("actions");
            },
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        //means sralable
        child: Column(
          children: [
            Image.asset(
              "Images/garbage-truck.png",
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.lightGreen,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              color: Colors.lightGreen,
              width: double.infinity, //takes all the space possible
              child: const Center(
                child: Text(
                  "tracker Map",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSwitch
                    ? Colors.red
                    : Colors.green, // ? means if true and : means else
              ),
              onPressed: () {
                debugPrint("thakiti");
              },
              child: const Text("Elevated"),
            ),
            OutlinedButton(
              onPressed: () {
                debugPrint("ghi kandhek");
              },
              child: const Text("outlined"),
            ),
            TextButton(
              onPressed: () {
                debugPrint("9ouwdtiha");
              },
              child: const Text("text button (red-flag)"),
            ),
            GestureDetector(
              behavior: HitTestBehavior
                  .opaque, //if you clicked in the whole row it works like in the icon
              onTap: () {
                debugPrint("touche");
              }, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                  ),
                  Text("Row widget"),
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Switch(
                value: isSwitch,
                onChanged: (bool newBool) {
                  setState(() {
                    isSwitch = newBool;
                  });
                }),
            Checkbox(
              value: isCheckbox,
              onChanged: (bool? newBool) {
                setState(() {
                  isCheckbox = newBool;
                });
              },
            ),
            Image.network(
                'https://www.thevectorimpact.com/wp-content/uploads/2021/10/toxic-people-traits.png'),
          ],
        ),
      ),
    );
  }
}
