import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter', style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.access_alarm, color: Color(0xFFFF00FF)),
        elevation: 10.0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => btAbout(context),
              child: const Text('About'),
            ),
            ElevatedButton(
              onPressed: () => btMessage(context),
              child: const Text('Message'),
            ),
            ElevatedButton(
              onPressed: () => btSettings(context),
              child: const Text('Form'),
            ),
            ElevatedButton(
              onPressed: () => btUsers(context),
              child: const Text('Users List'),
            ),
          ],
        ),
      ),
    );
  }
}

void btAbout(BuildContext context) {
  Navigator.pushNamed(
    context,
    '/about',
  );
}

void btMessage(BuildContext context) {
  Navigator.pushNamed(
    context,
    '/message',
    arguments: 'Message passé en paramètre',
  );
}

void btSettings(BuildContext context) {
  Navigator.pushNamed(
    context,
    '/settings',
  );
}

void btUsers(BuildContext context) {
  Navigator.pushNamed(
    context,
    '/usersList',
  );
}
