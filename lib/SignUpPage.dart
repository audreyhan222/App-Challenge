import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainPage.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final firestore = FirebaseFirestore.instance;
  @override
  var user_email = "";
  var user_password = "";
  var user_name = "";
  Widget build (BuildContext context) {
    return Scaffold(
      body: Center (
        child: Column (
          children: [
            ElevatedButton (
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text("Back")),
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

                firestore
                  .collection ("users")
                  .doc (user_email)
                  .set (user_data)
                  .onError((e, _) => print("Error writing document: $e"));

                final docRef = firestore.collection("users").doc(user_email);
                  docRef.get().then (
                    (DocumentSnapshot doc) async {
                      final data = doc.data() as Map<String, dynamic>;
                      globals.user_doc = doc;
                      globals.user_id = user_email;
                    },
                    onError: (e) => print("User email or password is incorrect."),
                  );

              }, 
              child: Text("Sign Up")
            ),
          ]
        )
      ),
    );
    
  }
}