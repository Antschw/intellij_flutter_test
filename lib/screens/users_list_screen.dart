import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intellij_flutter_test/api/user.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  List<Map<String, dynamic>> _userList = [];

  @override
  void initState() {
    super.initState();
    fetchAndSetUserList();
  }

  Future<void> fetchAndSetUserList() async {
    try {
      final userList = await fetchUserList();
      setState(() {
        _userList = userList;
      });
    } catch (e) {
      print("Exception while fetching user list: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: _userList.isNotEmpty
          ? ListView.builder(
              itemCount: _userList.length,
              itemBuilder: (context, index) {
                final user = _userList[index];
                return ListTile(
                  title: Text('${user['firstName']} ${user['lastName']}'),
                  subtitle: Text(user['email']),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
