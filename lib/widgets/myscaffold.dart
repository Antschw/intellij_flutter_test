import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final String name;
  final List<Widget> actions;

  const MyScaffold(
      {Key? key,
      required this.body,
      required this.name,
      this.actions = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.name, style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.app_registration, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/register',
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
