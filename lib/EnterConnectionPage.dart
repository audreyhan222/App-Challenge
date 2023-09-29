import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

class EnterConnectionPage extends StatefulWidget {
  const EnterConnectionPage({super.key});
  @override
  State<EnterConnectionPage> createState() => _EnterConnectionPageState();
}

class _EnterConnectionPageState extends State<EnterConnectionPage> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build (BuildContext context) {
    var user_email = "";
    var user_password = "";
    var user_name = "";
    return Scaffold (
      body: Center (
        child: Column (
          children: [
            TextField(
              obscureText: false,
              decoration: InputDecoration (
                border: OutlineInputBorder(),
                labelText: 'Enter Name'
              ),
              onChanged: (value) {
                user_name = value;
              }
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Email Address',
              ),
              onChanged: (value) {
                user_email = value;
              },
            ), 
            TextField(
              obscureText: true,
              decoration: InputDecoration (
                border: OutlineInputBorder(),
                labelText: 'Create Password'
              ),
              onChanged: (value) {
                user_password = value;
              }
            ),

            //sign up button
            ElevatedButton (
              onPressed: () {
                Navigator.pop(context);
                
                final user_data = <String, String> {
                  "Email" : user_email,
                  "Password": user_password,
                  "Username": user_name,
                  "Main Email": globals.user_id,
                };

                firestore
                  .collection ("users")
                  .doc (user_email)
                  .set (user_data)
                  .onError((e, _) => print("Error writing document: $e"));
                
                globals.user_doc = user_email;
                globals.user_id = user_email;
                globals.main_id = user_data["Main Email"];
              },
              child: Text("Create Connection"),
            ),
          ],
        ),
      ),
    );
  }
}