import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterConnectionPage extends StatefulWidget {
  const EnterConnectionPage({super.key});
  @override
  State<EnterConnectionPage> createState() => _EnterConnectionPageState();
}

class _EnterConnectionPageState extends State<EnterConnectionPage> {
  @override
  Widget build (BuildContext context) {
    var user_email = "";
    var user_password = "";
    var user_name = "";
    return Scaffold (
      appBar: AppBar (
        title: Text("Add Connection", style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 241, 230, 1),
        toolbarHeight: 80,
        elevation: 2.0,
        shadowColor: Colors.black,
      ),
      body: Center (
        child: Column (
          children: [
            Container (
              height: 70,
              width: 350,
              child: TextField(
              obscureText: false,
              decoration: InputDecoration (
                border: OutlineInputBorder(),
                labelText: 'Enter Name'
              ),
              onChanged: (value) {
                user_name = value;
              }
            ),
            ),

            Container(
              height: 70,
              width: 350,
              child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Email Address',
              ),
              onChanged: (value) {
                user_email = value;
              },
              ), 
            ),

            Container(
              height: 70,
              width: 350,
              child: TextField(
              obscureText: true,
              decoration: InputDecoration (
                border: OutlineInputBorder(),
                labelText: 'Create Password'
              ),
              onChanged: (value) {
                user_password = value;
              }
            ),
            ),

            //sign up button
            Container(
              height: 60,
              width: 300,
              child: GFButton (
              shape: GFButtonShape.pills,
              color: Color.fromRGBO(203, 153, 126, 1),
              onPressed: () {
                Navigator.pop(context);
                
                final user_data = <String, String> {
                  "Email" : user_email,
                  "Password": user_password,
                  "Username": user_name,
                  "Main Email": globals.user_id,
                };

                globals.firestore
                  .collection ("users")
                  .doc (user_email)
                  .set (user_data)
                  .onError((e, _) => print("Error writing document: $e"));
                
                globals.user_doc = user_email;
                globals.user_id = user_email;
                globals.main_id = user_data["Main Email"];
              },
              child: Text("Create Connection", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 20)),
            ),
            ),
          ],
        ),
      ),
    );
  }
}