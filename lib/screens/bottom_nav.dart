import 'dart:core';

import 'package:waste_management/screens/home_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/screens/report_detail.dart';
import 'package:waste_management/screens/report_screen.dart';
import 'package:waste_management/screens/zon_detail.dart';

import '../main.dart';



class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions =<Widget> [

    HomeScreen(),
    ReportScreen(),
    ReportScreen(),
    const Text("Profile"),

  ];

  static get index => null;

  

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: const Color(0xFF526480),
        items: const [
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "HOME"),
          // BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket), label: "HOME"),
          // BottomNavigationBarItem(icon: Icon(Icons.person), label: "HOME"),
        ],
      ),
    );
  }
}
