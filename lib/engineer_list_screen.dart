//engineer_list.dart
import 'package:flutter/material.dart';
import 'factorydashboard.dart';
import 'settings.dart';

class Engineer {
  final String name;
  final String position;

  Engineer(this.name, this.position);
}

class EngineerListScreen extends StatefulWidget {
  @override
  _EngineerListScreenState createState() => _EngineerListScreenState();
}

class _EngineerListScreenState extends State<EngineerListScreen> {
  // Map to store engineers for each factory
  Map<int, List<Engineer>> factoryEngineers = {
    1: [Engineer('John Doe', 'Chief Engineer')],
    2: [Engineer('Jane Smith', 'Assistant Engineer')],
    3: [Engineer('Emily Johnson', 'Junior Engineer')],
  };

  int selectedFactory = 1; // Default to Factory 1
  TextEditingController _nameController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  int _currentIndex = 0; // Track the selected index for navigation

  void _addEngineer() {
    final name = _nameController.text;
    final position = _positionController.text;

    if (name.isNotEmpty && position.isNotEmpty) {
      setState(() {
        factoryEngineers[selectedFactory]!.add(Engineer(name, position));
      });

      _nameController.clear();
      _positionController.clear();
      Navigator.pop(context);
    }
  }

  void _showAddEngineerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Engineer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _positionController,
                decoration: InputDecoration(labelText: 'Position'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addEngineer,
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteEngineer(int index) {
    setState(() {
      factoryEngineers[selectedFactory]!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Engineers'),
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
            // Already on Engineers screen
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FactoryDashboardScreen()),
            );
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
            DropdownButton<int>(
              value: selectedFactory,
              onChanged: (int? newValue) {
                setState(() {
                  selectedFactory = newValue!;
                });
              },
              items: [
                DropdownMenuItem(value: 1, child: Text('Factory 1')),
                DropdownMenuItem(value: 2, child: Text('Factory 2')),
                DropdownMenuItem(value: 3, child: Text('Factory 3')),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: factoryEngineers[selectedFactory]!.length,
                itemBuilder: (context, index) {
                  final engineer = factoryEngineers[selectedFactory]![index];
                  return Card(
                    child: ListTile(
                      title: Text(engineer.name),
                      subtitle: Text(engineer.position),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteEngineer(index),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showAddEngineerDialog,
              child: Text('Add Engineer'),
            ),
          ],
        ),
      ),
    );
  }
}
