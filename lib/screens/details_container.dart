// details_container.dart
import 'dart:core';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/screens/report_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


import '../services/auth.dart';
import '../shared/loading.dart';
import 'make_report.dart';


class DetailsScreen extends StatelessWidget {


  final DocumentSnapshot snap;

  DetailsScreen({ required this.snap}) ;

  @override
  Widget build(BuildContext context) {


    final date =  snap['Date'].toDate();
    final format = DateFormat("dd-MM-yyyy HH:mm:ss");
    final formattedDate = format.format(date);


      final textStyle = TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic);

    return Scaffold(
        appBar: AppBar(
          title: Text('Report Details'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 300,
                    child: Image.network(snap['Evidence']),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(

                    child: Text('Report ID: '+snap['ReportID'].toString(), style: textStyle),
                  ),
                  SizedBox(height: 10),
                  Container(

                    child: Text('Date Issued: '+ formattedDate, style: textStyle),
                  ),
                  SizedBox(height: 10),
                  Container(

                    child: Text('Description: '+snap['Deskripsi'].toString(), style: textStyle),
                  ),
                  SizedBox(height: 10),
                  Container(

                    child: Text('Reporter Email: '+snap['Email'].toString(), style: textStyle),
                  ),
                  SizedBox(height: 10),

                  Container(

                    child:
                    Text('Report Status: '+snap['Status'].toString(), style: textStyle),
                  ),
                  SizedBox(height: 10),
                  Container(

                    child: Text('Admin Remark: '+snap['Reason'].toString(), style: textStyle),
                  ),

                ],
              ),
            ],
          ),
        ));

  }
}

