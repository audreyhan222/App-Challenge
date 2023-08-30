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
              ), 
              TextField(
                obscureText: true,
                decoration: InputDecoration (
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password'
                )
              ),
              ElevatedButton (
                onPressed: () {
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