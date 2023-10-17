import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'package:getwidget/getwidget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var user_email = "";
  var user_password = "";
  var user_name = "";
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Sign In", style: TextStyle(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 25)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
      ),
      body: Center (
        child: Column (
          children: [
            SizedBox(height: 30),
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
            Container(
              height: 60,
              width: 300,
              child: GFButton (
                shape: GFButtonShape.pills,
                color: Color.fromRGBO(203, 153, 126, 1),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                  
                  final user_data = <String, String> {
                    "Email" : user_email,
                    "Password": user_password,
                    "Username": user_name,
                    "Main Email": user_email,
                  };

                  globals.firestore
                    .collection ("users")
                    .doc (user_email)
                    .set (user_data)
                    .onError((e, _) => print("Error writing document: $e"));
                  
                  
                  try {
                    var docRef = globals.firestore.collection("users").doc(user_email);
                  }
                  catch (error){
                    print("Something went wrong");
                  }

                  globals.user_doc = globals.firestore.collection("users").doc(user_email);
                  globals.user_id = user_email;
                  globals.main_id = user_email;
                  
                  // docRef.get().then (
                  //   (DocumentSnapshot doc) async {
                  //     //final data = doc.data() as Map<String, dynamic>;
                  //     globals.user_doc = globals.firestore.collection("users").doc(user_email);
                  //     globals.user_id = user_email;
                  //     globals.main_id = user_email;
                  //   }
                  // );

                }, 
                child: Text("Sign Up")
              ),
            ),
            
          ]
        )
      ),
    );
    
  }
}