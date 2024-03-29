import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
//import 'package:firebase_database/firebase_database.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';


class RealtimeDatabaseInsert extends StatelessWidget {
  RealtimeDatabaseInsert({Key? key}) : super(key: key);
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build (BuildContext context) {
    return Scaffold();
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "WeCare",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firestore = FirebaseFirestore.instance;
  globals.firestore = firestore;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'WeCare',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeCare',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          title: Text('WeCare', style: GoogleFonts.kanit(color: Color.fromRGBO(203, 153, 126, 1), fontSize: 45)),
          backgroundColor: Color.fromRGBO(255, 241, 230, 1),
          centerTitle: true,
        ),
        body: Center(
          child: Column (
            children: [
              Container (
                height: 400,
                decoration: BoxDecoration(
                ),
                child: Image.asset('assets/wecarelogo.png'),
              ),
              Container (
                height: 60,
                width: 300,
                child:
                  GFButton (
                    shape: GFButtonShape.pills,
                    color: Color.fromRGBO(203, 153, 126, 1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: Text("Login", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 25)),
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: 300,
                child: GFButton (
                  shape: GFButtonShape.pills,
                  type: GFButtonType.outline,
                  color: Color.fromRGBO(203, 153, 126, 1),
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    );
                  },
                  child: Text("Sign In", style: GoogleFonts.merriweather(fontSize: 25)),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
