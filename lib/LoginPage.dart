import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';


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
        title: Text("Login", style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        elevation: 2.0,
        toolbarOpacity: 1.0,
        shadowColor: Colors.black,
      ),
      body: Center(
        child: Column (
          children: [
              SizedBox(height:20),
              Container(
                height: 70,
                width: 350,
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Color.fromRGBO(203, 153, 126, 2)),
                    ),
                    hintStyle: TextStyle(color: Color.fromRGBO(203, 153, 126, 2)),
                    hintText: 'Enter email address',
                  ),
                  onChanged: (value) {
                    user_email = value;
                  },
                ), 
              ),
              SizedBox (height: 10),
              Container (
                height: 70,
                width: 350,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration (
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Color.fromRGBO(203, 153, 126, 2)),
                    ),
                    hintStyle: TextStyle(color: Color.fromRGBO(203, 153, 126, 2)),
                    hintText: 'Enter password'
                  ),
                  onChanged: (value) {
                    user_password = value;
                  }
                ),
              ),
              SizedBox(height: 20),
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
                          globals.user_name = data["Username"];
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MainPage()),
                          );
                        }
                      },
                      onError: (e) => print("User email or password is incorrect."),
                    );
                  }, 
                  child: Text("Login", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 20))),
              ),
            ]
          ),
              
        )
    );
  }
}
