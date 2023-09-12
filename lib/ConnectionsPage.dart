import 'package:flutter/material.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({super.key});
  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  @override
  Widget build (BuildContext context) {
    return Scaffold (
      body: Center (
        child: Column (
          children: [
            TextButton(
              onPressed: null,
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}