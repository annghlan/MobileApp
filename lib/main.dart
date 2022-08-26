import 'package:flutter/material.dart';
import 'package:individualproject/screens/login.dart';
import 'package:individualproject/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:individualproject/screens/HomePage.dart';

void main() async {
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          'register': (context) => MyRegister(),
          'login': (context) => MyLogin(),
        });
  }
}
