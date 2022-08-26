import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:individualproject/screens/MyBottomNav.dart';
import 'package:individualproject/screens/Body.dart';
// import 'package:individualproject/screens/ViewPlantDetails.dart';
// import 'package:individualproject/screens/CreatePlantDetails.dart';
import 'package:individualproject/screens/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  // final _storageRef=FirebaseStorage.instance;

  @override
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      actions: [
        FloatingActionButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyLogin()),
                (route) => false);
          },
          child: Icon(
            Icons.logout_sharp,
            color: Colors.red,
          ),
        )
      ],
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          lookValue();
        },
      ),
    );
  }

  void lookValue() async {
    print(("menu"));
    final _storageRef =
        await FirebaseStorage.instance.ref().child("Image").listAll();
    for (var prefix in _storageRef.prefixes) {
      // The prefixes under storageRef.
      // You can call listAll() recursively on them.
      print(prefix);
    }
    for (var item in _storageRef.items) {
      print("Items");
      print(item);
      // The items under storageRef.
    }
  }
}
