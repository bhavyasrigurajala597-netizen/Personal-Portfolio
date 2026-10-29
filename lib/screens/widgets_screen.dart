import 'package:flutter/material.dart';

// EXPERIMENT 2(a) & 2(b): Explore Text, Image, Container widgets and
// implement layouts using Row, Column, and Stack.
class WidgetsScreen extends StatelessWidget {
  const WidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widgets & Layouts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Text Widget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('This is a simple Text widget with default styling.'),
            const SizedBox(height: 20),

            const Text(
              'Container Widget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo),
              ),
              child: const Text('A Container with padding, margin, color, and border radius.'),
            ),

            const Text(
              'Image Widget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              // Using Icon here instead of a network image to avoid
              // requiring internet access; swap for Image.network(url) as needed.
              child: const Icon(Icons.image, size: 60, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            const Text(
              'Row Layout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _iconBox(Icons.book, 'Books'),
                _iconBox(Icons.laptop, 'Labs'),
                _iconBox(Icons.groups, 'Clubs'),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Column Layout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _listTile('Attendance', Icons.check_circle),
                _listTile('Timetable', Icons.schedule),
                _listTile('Notices', Icons.notifications),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Stack Layout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 150,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Overlayed text using Stack',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBox(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.indigo),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget _listTile(String title, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title),
      ),
    );
  }
}
