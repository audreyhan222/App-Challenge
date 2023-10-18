import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'EnterConnectionPage.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({Key key = const Key("")}) : super(key: key);
  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  TextEditingController messageController = TextEditingController();
  String displayedMessage = '';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Connections", style: TextStyle(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 25)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        shadowColor: Colors.black,
      ),
      body: Center(
        
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: firestore.collection("users").doc(globals.user_name).collection("messages").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var messages = snapshot.data!.docs;
                  List<Widget> messageWidgets = [];
                  for (var message in messages) {
                    var data = message.data() as Map<String, dynamic>;
                    var userName = message.id;
                    var text = data["text"];
                    messageWidgets.add(
                      ListTile(
                        title: Text(userName),
                        subtitle: Text(text),
                      ),
                    );
                  }
                  return ListView(children: messageWidgets);
                },
              ),
            ),
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
              padding: const EdgeInsets.all(2.0),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  labelText: "Add a message",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final message = messageController.text;
                final userName = globals.user_name; // Assuming you have the user's name in globals.user_name
// Add the message to Firestore subcollection
                addMessageToFirestore(message, userName);

                setState(() {
                  displayedMessage = message;
                });
              },
              child: Text("Submit Message"),
            ),
            Text(
              "Entered Message: $displayedMessage",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ]
        ),
          
        ),
      );
  }

  void addMessageToFirestore(String message, String userName) {
    final messagesCollection = globals.firestore.collection("users").doc(globals.main_id); // change to main_id
    final message_data = <String, String> {
      "text": message,
    };
    messagesCollection.get().then (
        (DocumentSnapshot doc) async {
          final data = doc.data() as Map<String, dynamic>;
          firestore
            .collection("users")
            .doc (data["Main Email"])
            .collection ("messages")
            .doc (userName)
            .set (message_data)
            .onError((e, _) => print("Error writing document: $e"));
        },
      onError: (e) => print("User email or password is incorrect."),
    );
  }
}