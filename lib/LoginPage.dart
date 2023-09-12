import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final firestore = FirebaseFirestore.instance;
  var user_email = "";
  var user_password = "";
  @override
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Center(
        child: Column (
          children: [
              ElevatedButton (
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: Text("Back")
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
                  labelText: 'Enter Password'
                ),
                onChanged: (value) {
                  user_password = value;
                }
              ),
              ElevatedButton (
                onPressed: () {
                  final docRef = firestore.collection("users").doc(user_email);
                  docRef.get().then (
                    (DocumentSnapshot doc) async {
                      final data = doc.data() as Map<String, dynamic>;
                      if (data["Password"] == user_password) {
                        var main_email = data["Main Account"];
                        globals.user_doc = firestore.collection("users").doc(main_email);
                        globals.user_id = user_email;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainPage()),
                        );
                      }
                    },
                    onError: (e) => print("User email or password is incorrect."),
                  );
                }, 
                child: Text("Login")),
            ]
          ),
              
        )
    );
  }
}
