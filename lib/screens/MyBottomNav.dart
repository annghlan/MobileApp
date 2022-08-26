import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:individualproject/screens/CreatePlantDetails.dart';
import 'package:individualproject/screens/ViewPlantDetails.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({
    Key? key,
  }) : super(key: key);
  _MyBottomNavBar createState() => _MyBottomNavBar();
}

class _MyBottomNavBar extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: Colors.white12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: new Image.asset('assets/lavender.png'),
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreatePlantDetails()));
            },
          ),
          IconButton(
            icon: Icon(Icons.view_carousel_outlined),
            // Image.asset("assets/love.png"),
            iconSize: 30,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewPlantDetails()));
            },
          ),
          IconButton(
            icon: Icon(Icons.account_box_outlined),
            iconSize: 30,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
