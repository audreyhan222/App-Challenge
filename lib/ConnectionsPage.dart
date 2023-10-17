import 'package:flutter/material.dart';
import 'EnterConnectionPage.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({Key key = const Key("")}) : super(key: key);
  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  TextEditingController messageController = TextEditingController();
  String displayedMessage = ''; // To store and display the entered message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Connections", style: TextStyle(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 25)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EnterConnectionPage()),
                );
              },
              child: Text("Add a Connection"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  labelText: "Add a message",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  displayedMessage = messageController.text;
                });
              },
              child: Text("Submit Message"),
            ),
            Text(
              "Entered Message: $displayedMessage",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
