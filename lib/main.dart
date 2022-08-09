import 'package:flutter/material.dart';
import 'package:individualproject/login.dart';
import 'package:individualproject/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // initializing firebase 
  // asyn function that help to excute task in future

  // await interrupt the process flow unitl the async methods completes.

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyRegister(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
    },
  ));
}

