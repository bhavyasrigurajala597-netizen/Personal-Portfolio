import 'package:flutter/material.dart';

// EXPERIMENT 3(a) & 3(b): Design a responsive UI that adapts to different
// screen sizes, using MediaQuery and LayoutBuilder as breakpoints.
class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive UI')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Screen width: ${screenWidth.toStringAsFixed(0)} px'),
            const SizedBox(height: 12),
            // LayoutBuilder gives the constraints of the available space,
            // which is the recommended way to build responsive widgets.
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Breakpoints: mobile < 600, tablet < 1000, desktop >= 1000
                  int columns;
                  if (constraints.maxWidth < 600) {
                    columns = 1;
                  } else if (constraints.maxWidth < 1000) {
                    columns = 2;
                  } else {
                    columns = 3;
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.2,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.indigo.shade50,
                        child: Center(
                          child: Text(
                            'Card ${index + 1}\n($columns column layout)',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
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
