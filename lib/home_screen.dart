import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:plant_app/components/my_bottom_nav_bar.dart';
//import 'package:plant_app/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {},
        ),
      ),
    );
  }
}
