import 'package:flutter/material.dart';
import 'package:intellij_flutter_test/widgets/myscaffold.dart';


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
    return MyScaffold(
      name: 'Home',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.indigo.shade500),
              ),
              onPressed: () => btAbout(context),
              child: const Text(
                'A propos',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.indigo.shade500),
              ),
              onPressed: () => btMessage(context),
              child: const Text(
                'Messages',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.indigo.shade500),
              ),
              onPressed: () => btSettings(context),
              child: const Text(
                'Formulaire',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.indigo.shade500),
              ),
              onPressed: () => btUsers(context),
              child: const Text(
                'Liste des utilisateurs',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
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
