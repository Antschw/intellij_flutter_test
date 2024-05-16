import 'package:flutter/material.dart';
import 'package:intellij_flutter_test/screens/about_screen.dart';
import 'package:intellij_flutter_test/screens/home_screen.dart';
import 'package:intellij_flutter_test/screens/message_screen.dart';
import 'package:intellij_flutter_test/screens/settings_screen.dart';
import 'package:intellij_flutter_test/screens/users_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
        '/message': (context) => const MessageScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/usersList': (context) => const UsersListScreen(),
      },
    );
  }
}
