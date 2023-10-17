import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var user_email = "";
  var user_password = "";
  @override
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar (
        title: Text("Login", style: TextStyle(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 25)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
      ),
      body: Center(
        child: Column (
          children: [
              SizedBox(height:20),
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
              Container(
                height: 60,
                width: 300,
                child: GFButton (
                  shape: GFButtonShape.pills,
                  color: Color.fromRGBO(203, 153, 126, 1),
                  onPressed: () {
                    final docRef = globals.firestore.collection("users").doc(user_email);
                    docRef.get().then (
                      (DocumentSnapshot doc) async {
                        final data = doc.data() as Map<String, dynamic>;
                        if (data["Password"] == user_password) {
                          var main_email = data["Main Account"];
                          globals.user_doc = globals.firestore.collection("users").doc(main_email);
                          globals.user_id = user_email;
                          globals.main_id = data["Main Email"];
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
              ),
            ]
          ),
              
        )
    );
  }
}
