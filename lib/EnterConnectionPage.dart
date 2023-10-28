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
        title: Text("Add Connection", style: GoogleFonts.kanit(color: Color.fromRGBO(119, 119, 100, 1), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(240, 239, 235, 1),
        toolbarHeight: 80,
        toolbarOpacity: 1.0,
        shadowColor: Colors.black,
        elevation: 2.0,
      ),
      body: Center (
        child: Column (
          children: [
            SizedBox(height: 30),
            Container (
              height: 70,
              width: 350,
              child: TextField(
              obscureText: false,
              decoration: InputDecoration (
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Color.fromRGBO(203, 153, 126, 2)),
                ),
                labelText: 'Enter Name'
              ),
              onChanged: (value) {
                user_name = value;
              }
            ),
            ),
            SizedBox(height: 10),
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
                labelText: 'Enter Email Address',
              ),
              onChanged: (value) {
                user_email = value;
              },
              ), 
            ),
            SizedBox(height:10),

            Container(
              height: 70,
              width: 350,
              child: TextField(
              obscureText: true,
              decoration: InputDecoration (
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Color.fromRGBO(203, 153, 126, 2)),
                ),
                labelText: 'Create Password'
              ),
              onChanged: (value) {
                user_password = value;
              }
            ),
            ),
            SizedBox(height:10),

            //sign up button
            Container(
              height: 60,
              width: 300,
              child: GFButton (
              shape: GFButtonShape.pills,
              color: Color.fromRGBO(165, 165, 141, 1),
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