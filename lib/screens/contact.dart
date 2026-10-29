// Source - https://stackoverflow.com/a/65540119
// Posted by CopsOnRoad, modified by community. See post 'Timeline' for change history
// Retrieved 2026-07-25, License - CC BY-SA 4.0
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;

  const CustomAppBar({
    super.key,
    required this.child,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.orange,
      alignment: Alignment.center,
      child: child,
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: const Text('Contact Us', style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: const Center(
        child: Text('Contact details here.'),
      ),
    );
  }
}
