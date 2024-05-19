//factorydashboard
import 'package:flutter/material.dart';
import 'engineer_list_screen.dart';
import 'settings.dart';

class FactoryDashboardScreen extends StatefulWidget {
  @override
  _FactoryDashboardScreenState createState() => _FactoryDashboardScreenState();
}

class _FactoryDashboardScreenState extends State<FactoryDashboardScreen> {
  int selectedFactory = 2;
  int _currentIndex = 1; // Track the selected index for navigation

  // Sensor readings for each factory
  final Map<int, Map<String, String>> sensorReadings = {
    1: {
      'steamPressure': '30.00',
      'steamFlow': '20.00',
      'waterLevel': '50.00',
      'powerFrequency': '49.90'
    },
    2: {
      'steamPressure': '34.19',
      'steamFlow': '22.82',
      'waterLevel': '55.41',
      'powerFrequency': '50.08'
    },
    3: {
      'steamPressure': '32.50',
      'steamFlow': '21.50',
      'waterLevel': '53.00',
      'powerFrequency': '49.95'
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Already on Dashboard screen
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Factory $selectedFactory',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            buildSensorContainer(),
            SizedBox(height: 20),
            Text(
              '3891.9kW',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '2024-04-26 13:45:25',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  factoryButton(1),
                  factoryButton(2),
                  factoryButton(3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSensorContainer() {
    var readings = sensorReadings[selectedFactory];

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Sensor Readings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sensorInfo('Steam Pressure',
                    readings?['steamPressure'] ?? 'N/A', 'bar', Colors.green),
                sensorInfo('Steam Flow', readings?['steamFlow'] ?? 'N/A', 'T/H',
                    Colors.red),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sensorInfo('Water Level', readings?['waterLevel'] ?? 'N/A', '%',
                    Colors.green),
                sensorInfo('Power Frequency',
                    readings?['powerFrequency'] ?? 'N/A', 'Hz', Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sensorInfo(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Text(
          '$value $unit',
          style: TextStyle(fontSize: 24, color: color),
        ),
      ],
    );
  }

  Widget factoryButton(int factoryNumber) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFactory = factoryNumber;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedFactory == factoryNumber ? Colors.pink : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text('Factory $factoryNumber'),
      ),
    );
  }
}
