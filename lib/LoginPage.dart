import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  var user_email = "";
  var user_password = "";
  Widget build (BuildContext context) {
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
                  print(user_email);
                  print(user_password);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                }, 
                child: Text("Login")),
            ]
          ),
              
        )
    );
  }
}