
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:waste_management/screens/assets/Guest.dart';
import 'package:waste_management/screens/home_screen.dart';
import 'authenticate/authenticate.dart';
import 'bottom_nav.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Guest user = Provider.of<Guest>(context);
    //final uid = user.Uid!;
    //return either the Home or Authenticate widget
    if (user == null){
      print("homescreen null wrapper");
      return Authenticate();
    } else {
      print("homescreen wrapper");
     return HomeScreen();
   }

  }
}