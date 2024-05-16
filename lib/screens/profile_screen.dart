import 'package:flutter/material.dart';
import 'package:intellij_flutter_test/utils/secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SecureStorage storage = SecureStorage();
  String _email = '';

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  getEmail() async {
    final credentials = await storage.readCredentials();
    if (mounted) {
      setState(() {
        _email = credentials['email'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Email: $_email',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}