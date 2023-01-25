import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:waste_management/screens/authenticate/authenticate.dart';
import 'package:waste_management/screens/bottom_nav.dart';
import 'package:waste_management/services/auth.dart';
import 'firebase_options.dart';


Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    name: "DeDumpster",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool loading = false;
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      home: StreamBuilder(
          stream: AuthService().guest3,
        builder: (context, snapshot) {

          if (snapshot.hasData){
            print("homescreen null wragggpper");
            return BottomNav();
          } else {

            print("homescreen ggg");
            return Authenticate();
          }
        },
        ),
    );

  }
}
