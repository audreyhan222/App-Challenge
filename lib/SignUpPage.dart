import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Email Address',
              ),
            ), 
            TextField(
              obscureText: true,
              decoration: InputDecoration (
                border: OutlineInputBorder(),
                labelText: 'Create Password'
              )
            ),
            ElevatedButton (
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                );
              }, 
              child: Text("Sign Up")),
          ]
        )
      ),
    );
    
  }
}