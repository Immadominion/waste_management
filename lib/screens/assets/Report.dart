
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Report {

  late final String Email;
  late final String Nama;
  late final String ReportID;
  late final LatLng Location;
  late final String Status;
  late final String Note;

  Report({

    required this.Email,
    required this.Nama,
    required this.ReportID,
    required this.Location,
    required this.Status,
    required this.Note,
  });

  static Report fromJson(Map<String, dynamic> json) => Report (
    Email: json['Email'],
    Nama: json['Nama'],
    ReportID: json['ReportID'],
    Location: json['RepLocation'],
    Status: json['Status'],
    Note: json['Note'],
  );

}
