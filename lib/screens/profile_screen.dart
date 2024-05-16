import 'package:flutter/material.dart';
import 'package:intellij_flutter_test/utils/secure_storage.dart';
import 'package:intellij_flutter_test/api/user.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SecureStorage storage = SecureStorage();
  String _email = '';
  String _firstName = '';
  String _lastName = '';

  @override
  void initState() {
    super.initState();
    getEmailAndName();
  }

  getEmailAndName() async {
    final credentials = await storage.readCredentials();
    if (mounted) {
      setState(() {
        _email = credentials['email'] ?? '';
      });
    }
    final responseData = await getUserData();
    if (responseData != null && mounted) {
      setState(() {
        _firstName = responseData['user']['firstName'] ?? '';
        _lastName = responseData['user']['lastName'] ?? '';
      });
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final credentials = await storage.readCredentials();
    try {
      final response = await login(credentials['email'] ?? '', credentials['password'] ?? '');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get user data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Exception while fetching user data: $e");
      return null;
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
            Text(
              'First Name: $_firstName',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Last Name: $_lastName',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
