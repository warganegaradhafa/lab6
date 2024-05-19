//settings.dart
import 'package:flutter/material.dart';
import 'factorydashboard.dart';
import 'engineer_list_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentIndex = 2; // Track the selected index for navigation

  // Minimum threshold values for each sensor
  Map<String, double> thresholds = {
    'Steam Pressure': 30.0,
    'Steam Flow': 20.0,
    'Water Level': 50.0,
    'Power Frequency': 48.0,
  };

  // Text editing controllers for each threshold input field
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    thresholds.forEach((key, value) {
      controllers[key] = TextEditingController(text: value.toString());
    });
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Engineers'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EngineerListScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FactoryDashboardScreen()),
            );
          } else if (index == 2) {
            // Already on Settings screen
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'Minimum Thresholds',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: thresholds.keys.map((key) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(key, style: TextStyle(fontSize: 16)),
                            SizedBox(height: 10),
                            TextField(
                              controller: controllers[key],
                              decoration: InputDecoration(
                                labelText: 'Threshold value for $key',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  thresholds[key] = double.tryParse(value) ??
                                      thresholds[key]!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
