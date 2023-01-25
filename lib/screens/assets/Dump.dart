import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Dump {
  late String id;
  late final LatLng Location;
  late final String note;
  late String Status;



  Dump({
    this.id = '',
    required this.Location,
    required this.note,
    required this.Status,
  });

  static Dump fromJson(Map<String, dynamic> json ) => Dump(
    id: json['DumpsterID'] ?? '',
    Location: json['Dlocation'] ?? '',
    note: json['Note'] ?? '',
    Status: json['Status'] ?? '',
  );

  }



