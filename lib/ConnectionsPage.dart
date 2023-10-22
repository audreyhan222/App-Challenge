import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'EnterConnectionPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

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
        title: Text("Connections", style: GoogleFonts.kanit(color: Color.fromRGBO(119, 119, 100, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(240, 239, 235, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        shadowColor: Colors.black,
        elevation: 2.0,
      ),
      body: Center(
        
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: firestore.collection("users").doc(globals.main_id).collection("messages").snapshots(),
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
                      Container (
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row (
                            children: [
                              SizedBox(width:5),
                              Container (
                                height: 60,
                                width: 110,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    color: Color.fromRGBO(204, 204, 182, 1),
                                    // border: Border.all(
                                    //   color: Color.fromRGBO(165, 165, 141,1),
                                    // )
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                  userName,
                                  style: GoogleFonts.merriweather(color: Color.fromRGBO(22, 22, 18, 0.988), fontSize: 15),
                                ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container (
                                height: 60,
                                width: 230,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  border: Border.all(
                                    color: Color.fromRGBO(165, 165, 141,1),
                                  ),
                                ),
                                child: 
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      text,
                                      style: GoogleFonts.merriweather(color: Color.fromRGBO(119, 119, 100, 0.996), fontSize: 15),
                                    ),
                                  ),
                              ),
                            ]
                          ),],
                        ),
                      ),
                    );
                  }
                  return ListView(children: messageWidgets);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 70,
                width: 320,
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final message = messageController.text;
                      final userName = globals.user_name;
                      // Add the message to Firestore subcollection
                      addMessageToFirestore(message, userName);
                      messageController.clear();
                      setState(() {
                        ConnectionsPage();
                      });
                    },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Color.fromRGBO(119, 119, 100, 2)),
                    ),
                    hintStyle: TextStyle(color: Color.fromRGBO(119, 119, 100, 2)),
                    hintText: "Add a message",
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container (
              height: 60,
              width: 300,
              child: GFButton(
                shape: GFButtonShape.pills,
                color: Color.fromRGBO(165, 165, 141, 1),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EnterConnectionPage()),
                  );
                },
                child: Text("Add a Connection", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 20)),
              ),
            ),
            SizedBox(height: 20),
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