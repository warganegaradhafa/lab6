//threshold_settings_page
import 'package:flutter/material.dart';

class ThresholdSettingsPage extends StatefulWidget {
  @override
  _ThresholdSettingsPageState createState() => _ThresholdSettingsPageState();
}

class _ThresholdSettingsPageState extends State<ThresholdSettingsPage> {
  final Map<String, double> _thresholds = {
    'Steam Pressure': 30.0,
    'Steam Flow': 25.0,
    'Water Level': 50.0,
    'Power Frequency': 50.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minimum Threshold Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: _thresholds.keys.map((key) {
                  return ThresholdCard(
                    title: key,
                    value: _thresholds[key]!,
                    onChanged: (newValue) {
                      setState(() {
                        _thresholds[key] = newValue;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Save the thresholds to the backend or local storage
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThresholdCard extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;

  ThresholdCard(
      {required this.title, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Slider(
              value: value,
              min: 0,
              max: 100,
              onChanged: onChanged,
              divisions: 100,
              label: value.toString(),
            ),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
