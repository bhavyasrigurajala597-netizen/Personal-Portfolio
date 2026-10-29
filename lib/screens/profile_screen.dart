import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 237, 236),
      // ---------------- AppBar ----------------
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      // ---------------- Column (overall layout) ----------------
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---------------- Container (card) wrapping Stack ----------------
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // ---------------- Stack: profile image over banner ----------------
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Banner
                      Container(
                        height: 140,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            colors: [Colors.deepPurple, Colors.purpleAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      // Circle profile image, offset to overlap the banner
                      Positioned(
                        bottom: -45,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.deepPurple,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/300?img=12',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Space for the overlapping avatar
                  const SizedBox(height: 55),

                  // ---------------- Text: name & bio ----------------
                  const Text(
                    'Gurajala Bhavyasri',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Flutter Developer • Coffee Lover • Building beautiful apps one widget at a time ☕📱',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Divider(indent: 24, endIndent: 24),

                  // ---------------- Row: social stats ----------------
                 // Padding(
                 //   padding: const EdgeInsets.symmetric(vertical: 16),
                   // child: Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //children: const [
                        //_StatItem(label: 'Posts', value: '128'),
                        //_VerticalDivider(),
                        //_StatItem(label: 'Followers', value: '3.2K'),
                        //_VerticalDivider(),
                        //_StatItem(label: 'Following', value: '412'),
                     // ],
                   // ),
                  //),const SizedBox(height: 20),

const Text(
  "My Skills",
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 15),

Wrap(
  alignment: WrapAlignment.center,
  spacing: 10,
  runSpacing: 10,
  children: const [

    Chip(
      avatar: Icon(Icons.flutter_dash, color: Colors.blue),
      label: Text("Flutter"),
    ),

    Chip(
      avatar: Icon(Icons.code, color: Colors.deepPurple),
      label: Text("Dart"),
    ),

    Chip(
      avatar: Icon(Icons.computer, color: Colors.green),
      label: Text("C"),
    ),

    Chip(
      avatar: Icon(Icons.phone_android, color: Colors.orange),
      label: Text("Android"),
    ),

    Chip(
      avatar: Icon(Icons.palette, color: Colors.purple),
      label: Text("UI Design"),
    ),

    Chip(
      avatar: Icon(Icons.storage, color: Colors.red),
      label: Text("Firebase"),
    ),

  ],
),

const SizedBox(height: 20),

                ],
              ),
            ),

            // ---------------- Follow / Message buttons (Row) ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Good Communication'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.deepPurple,
                        side: const BorderSide(color: Colors.deepPurple),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Fast learner'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

