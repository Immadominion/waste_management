import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelper{
  NetworkHelper({required this.startLng,required this.startLat,required this.endLng,required this.endLat});

  final String url ='https://api.openrouteservice.org/v2/directions/';
  final String apiKey = '5b3ce3597851110001cf624851041b06a00f4326bcd01cd04bfbf415';
  final String journeyMode = 'driving-car';// Change it if you want
  List geojson = [
    {"coordinates":[[2.311908881410589, 102.3177929458618],[2.309710605041606, 102.31826330465866],[2.30854324310394, 102.32105511171106]]}
  ];
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;
  String bearer = "5b3ce3597851110001cf624851041b06a00f4326bcd01cd04bfbf415";

  Future getData() async{
    //http.Response response = await http.post(Uri.parse('https://api.openrouteservice.org/v2/directions/driving-car/json'));
    //http.Response response = await http.get(Uri.parse('$url$journeyMode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat'));
    //print("$url$journeyMode?$apiKey&start=$startLng,$startLat&end=$endLng,$endLat");
    final uri = Uri.parse('https://api.openrouteservice.org/v2/directions/driving-car/json');
    final headers = {'Content-Type': 'application/json',
                     'Authorization': 'Bearer $bearer'};
    Map<String, dynamic> body = {"coordinates":[[102.3177929458618,2.311908881410589],[102.31826330465866,2.309710605041606],[102.32105511171106,2.30854324310394]]};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');


    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    //int statusCode = response.statusCode;
    //String responseBody = response.body;
    print(response.statusCode);
    if(response.statusCode == 200) {
      String data = response.body;
      print(response.body);
      return jsonDecode(data);

    }
    else{
      print(response.statusCode);
    }
  }
}