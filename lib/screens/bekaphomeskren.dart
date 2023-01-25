import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:open_route_service/open_route_service.dart';
import 'dart:ui' as ui;
import 'package:google_map_polyutil/google_map_polyutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_management/screens/wrapper.dart';
import 'package:waste_management/screens/zon_detail.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:waste_management/services/auth.dart';
import 'package:waste_management/shared/loading.dart';

import '../main.dart';
import 'assets/Dump.dart';
import 'assets/Guest.dart';
import 'bottom_nav.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}



class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late GoogleMapController mapController;
  LocationData? currentLocation;
  final AuthService _auth = AuthService();
  late Animation<double> _animation;
  late AnimationController _animationController;
  final OpenRouteService client = OpenRouteService(apiKey: '5b3ce3597851110001cf624851041b06a00f4326bcd01cd04bfbf415');
  Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; // For holding instance of Marker
  final Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Marker> markers2 = {};
  List<LatLng> TrashPoint = [];
  List<LatLng> polyPoints = [];
  List<LatLng> polyPointsZon2 = [];// For holding Co-ordinates as LatLng
  List<LatLng> polygonLatLong1 = [
    LatLng(2.237284325662209, 102.28816457791484),
    LatLng(2.234219235217379, 102.2847362790345),
    LatLng(2.2312623183727136, 102.27975622381886),
    LatLng(2.2276202540881958, 102.28109145601438),
    LatLng(2.2241945418389473, 102.28571063766364),
    LatLng(2.2204082190455128, 102.28794805377501),
    LatLng(2.2182446016638164, 102.29141244001198),
    LatLng(2.2159728000070213, 102.29401072968969),
    LatLng(2.216874309018324, 102.29873817340886),
    LatLng(2.2198673149969554, 102.29830512512925),
    LatLng(2.2237978799064986, 102.29902687226195),
    LatLng(2.228593876116099, 102.29588727223472),
    LatLng(2.2312623183727136, 102.29217027450132),
    LatLng(2.233822575986239, 102.29018546988638),
    LatLng(2.2372482658118518, 102.28820066527148),
  ];

  List<LatLng> PolygonAEON = [
    LatLng(2.2379710059938502, 102.28775324373495),
    LatLng(2.2387873089752013, 102.28530246484839),
    LatLng(2.2381614767301543, 102.283913690146),
    LatLng(2.2382158969359778, 102.28241599193753),
    LatLng(2.2388417291577944, 102.28119060249422),
    LatLng(2.2393315107101905, 102.27950228815014),
    LatLng(2.238760098883148, 102.27890320886675),
    LatLng(2.237426803753776, 102.27898490149632),
    LatLng(2.236800970928023, 102.27914828675542),
    LatLng(2.2359030364073225, 102.27974736603879),
    LatLng(2.2351955724585806, 102.27993798217443),
    LatLng(2.2340527453596364, 102.27950228815014),
    LatLng(2.2328282867668383, 102.27942059552059),
    LatLng(2.231739878272245, 102.27963844253273),
    LatLng(2.232583394925822, 102.28124506424727),
    LatLng(2.2338350639066307, 102.28342353436868),
    LatLng(2.23486905052108, 102.28492123257713),
    LatLng(2.2377261150108074, 102.28780770548799),
  ];
  List<LatLng> PolygonUTEM = [
    LatLng(2.321294148483201, 102.32650307371136),
    LatLng(2.320837873731179, 102.32392626644112),
    LatLng(2.321196375334451, 102.32151254823864),
    LatLng(2.3209356469047244, 102.31942500817163),
    LatLng(2.320153461327055, 102.3175331749859),
    LatLng(2.3174809906732112, 102.31544563491887),
    LatLng(2.315949206438324, 102.3146301895802),
    LatLng(2.3123641730333757, 102.31374950861442),
    LatLng(2.311288661244939, 102.31355380173315),
    LatLng(2.306693283520177, 102.31374950861442),
    LatLng(2.3039556046253016, 102.31361903736025),
    LatLng(2.30285777546948, 102.31665823705515),
    LatLng(2.3009058308082477, 102.32451139131338),
    LatLng(2.3039118244747616, 102.326035137662),
    LatLng(2.307347238038096, 102.32709003898024),
    LatLng(2.309572444667914, 102.32650398269233),
    LatLng(2.311290145647734, 102.32701189814186),
    LatLng(2.3142180402534773, 102.32654305311154),
    LatLng(2.317263044229201, 102.32669933478832),
    LatLng(2.319214966410883, 102.32685561646508),
    LatLng(2.3214401544128025, 102.32669933478832),
  ];

  List<ORSCoordinate> Zon1 = [];
  List<ORSCoordinate> Zon2 = [];
  List<ORSCoordinate> hh = [];

  final List<LatLng> _markerLocations = [
    LatLng(2.229497546955978, 102.28773216294645),
    // LatLng(2.237181912679846, 102.27944782639709),
    // LatLng(2.2375356442179406, 102.28274276245573),
    // LatLng(2.230190628007292, 102.2871861324986),
    // LatLng(2.229497546955978, 102.28773216294645),
    // LatLng(2.2296990811960566, 102.28800271857376),

  ];

  final List<LatLng> _markerLocations2 = [
    LatLng(2.2302208475112035, 102.287110054672),
    LatLng(2.229497546955978, 102.28773216294645),

    // LatLng(2.2375356442179406, 102.28274276245573),
    // LatLng(2.230190628007292, 102.2871861324986),
    // LatLng(2.229497546955978, 102.28773216294645),
    // LatLng(2.2296990811960566, 102.28800271857376),

  ];

  final List<Dump> test = [];
  final List<Guest> test2 = [];

  final listOfLatLngs = [
    LatLng(50.08155798581401, 8.24199914932251),
    LatLng(50.08053216096673, 8.242063522338867),
    LatLng(50.080614778545716, 8.243619203567505),
    LatLng(50.0816956787534, 8.243404626846313),
    LatLng(50.08155798581401, 8.24199914932251),
  ];
  List<Guest> GuestList = [];
  List<Dump> DumpList = [];
  var data;
  var count = 0;
  var countMarkerMerbok = 0;
  var countAEON = 0;
  var countUTEM = 0;
  late bool nilai;
  late bool nilai2;
  late bool nilai3;
  double startLat2 = 0;
  double startLng2 = 0;
  double endLat = 2.22808668610202;
  double endLng = 102.28956120341273;
  Set<Polyline> baru = {};
  String optimizationDataPost = "";
  List<ORSCoordinate> routeZon1Coordinates = [];
  List<ORSCoordinate> routeZon2Coordinates =[];
  var db = FirebaseFirestore.instance;

  late final newMarkers = <Marker>{};

  getDump() async {

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    CollectionReference DumpCollection = _firestore.collection('Dumpster');
    int ind = 0;
    await DumpCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        GeoPoint pos = doc['DLocation'];

        _markerLocations.add(LatLng(pos.latitude, pos.longitude));
        _markerLocations2.add(LatLng(pos.latitude, pos.longitude));
        Dump dump = Dump.fromJson({
          'Dlocation': LatLng(pos.latitude, pos.longitude),
          'DumpsterID': doc['DumpsterID'],
          'Note': doc['Note'],
          'Status': doc['Status'],

        });
        DumpList.add(dump);
        print("dimana733 ${_markerLocations[0].latitude}");
        print("dimana7 ${DumpList[ind].id}");
        ind++;
      });
    });

    return DumpList;

  }
  void getCurrentLocation() async {
    Location location = Location();
    await location.getLocation().then((location) {currentLocation = location;},);
    await getDump();

    // Timer.periodic(new Duration(seconds: 5), (timer) async {
    await setMarkers2();

    location.onLocationChanged.listen(
          (newLoc) async {
        currentLocation = newLoc;
        startLat2 = currentLocation!.latitude!;
        startLng2 = currentLocation!.longitude!;




        print("disni $startLng2");
        print("kelako$test");

      },

    );
    setState(() {});
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  setMarkers2() async {

    final Uint8List markerIcon2 = await getBytesFromAsset('lib/screens/assets/images/Dumpster.png', 150);
    final Uint8List markerIcon = await getBytesFromAsset('lib/screens/assets/images/DriverIcon.png', 150);
    Marker resultMarker = Marker(
      markerId: MarkerId("LiveMarker"),
      position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      icon: BitmapDescriptor.fromBytes(markerIcon),
      infoWindow: InfoWindow(
        title: "IM A driver",
        snippet: "Driver ID: D00001",
      ),
    );


    int berapa = _markerLocations.length - 2;
    print("dfgdhdh $berapa");
    for (int count = 0; count <= berapa; count++) {
      final updatezon = FirebaseFirestore.instance.collection('Dumpster')
          .doc(DumpList[count].id);


      LatLng g = DumpList[count].Location;
      markers2.add(Marker(
          markerId: MarkerId(DumpList[count].id),
          position: LatLng(g.latitude, g.longitude),
          icon: BitmapDescriptor.fromBytes(markerIcon2),
          infoWindow: InfoWindow(

            title: DumpList[count].id,
            snippet: DumpList[count].Status,
          ),

          anchor: const Offset(0.5, 0.5)

      ));


      countMarkerMerbok = 0;
      countUTEM = 0;
      countAEON = 0;
      nilai =  await GoogleMapPolyUtil.containsLocation(
          polygon: polygonLatLong1,
          point: LatLng(g.latitude, g.longitude));
      if(nilai == true){
        updatezon.update({'Zone':'1'});
        countMarkerMerbok ++;
        Zon1.add(ORSCoordinate(latitude: g.latitude, longitude: g.longitude ));

      }else if(nilai == false){
        nilai2 =  await GoogleMapPolyUtil.containsLocation(
            polygon: PolygonAEON, point: LatLng(g.latitude, g.longitude));
        if(nilai2 == true){
          countAEON ++;
          updatezon.update({'Zone':'2'});
          Zon2.add(ORSCoordinate(latitude: g.latitude, longitude: g.longitude));
        }else if(nilai2 == false){
          nilai3 =  await GoogleMapPolyUtil.containsLocation(
              polygon: PolygonUTEM, point: LatLng(g.latitude, g.longitude));
          if(nilai3 == true){
            countUTEM ++;
            updatezon.update({'Zone':'3'});
          }
        }
      }
    }

    Zon1.add(ORSCoordinate(latitude: currentLocation!.latitude!, longitude:currentLocation!.longitude!));
    Zon2.add(ORSCoordinate(latitude: currentLocation!.latitude!, longitude:currentLocation!.longitude!));
    markers2.add(resultMarker);

    if(Zon1.isNotEmpty && Zon2.isNotEmpty){
      routeZon1Coordinates = await client.directionsMultiRouteCoordsPost(
          coordinates: Zon1
      );
      routeZon2Coordinates = await client.directionsMultiRouteCoordsPost(
          coordinates: Zon2
      );

      if (polyLines.isNotEmpty) {
        Zon1 =  [];
        Zon2 =  [];
        polyLines.clear();
        polyPoints.clear();
        polyPointsZon2.clear();// EMPTY THE VARIABLE <---------

        for( var lat in routeZon1Coordinates )
        {
          polyPoints.add(LatLng(lat.latitude,lat.longitude));
        }

        for( var lat in routeZon2Coordinates )
        {
          polyPointsZon2.add(LatLng(lat.latitude,lat.longitude));
        }
        setPolyLines();


      } else if (polyLines.isEmpty) {

        for( var lat in routeZon1Coordinates )
        {
          polyPoints.add(LatLng(lat.latitude,lat.longitude));
        }

        for( var lat in routeZon2Coordinates )
        {
          polyPointsZon2.add(LatLng(lat.latitude,lat.longitude));
        }
        setPolyLines();

      }
    }
    else{
      print("ARRAY EMPTY");
    }
  }
  setPoly(){
    _polygons.clear();
//MERBOK REGION
    if(countMarkerMerbok >= 3){

      _polygons.add(
        Polygon(
          polygonId: PolygonId("2"),
          points: polygonLatLong1,
          fillColor: (Colors.red.withOpacity(0.2)),
          strokeWidth: 1,
          consumeTapEvents: true,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZonDetail(index: 1,)));
          },
        ),
      );
    }
    else if(countMarkerMerbok <= 2){

      _polygons.add(
        Polygon(
          polygonId: PolygonId("1"),
          points: polygonLatLong1,
          fillColor: (Colors.green.withOpacity(0.2)),
          strokeWidth: 1,
          consumeTapEvents: true,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZonDetail(index: 1,)));
          },
        ),
      );

    }

    if(countAEON >= 5){

      _polygons.add(
        Polygon(
          polygonId: PolygonId("3"),
          points: PolygonAEON,
          fillColor: (Colors.red.withOpacity(0.2)),
          strokeWidth: 1,
          consumeTapEvents: true,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZonDetail(index: 2,)));
          },
        ),
      );
    }
    else if(countAEON <= 5){

      _polygons.add(
        Polygon(
          polygonId: PolygonId("4"),
          points: PolygonAEON,
          fillColor: (Colors.green.withOpacity(0.2)),
          strokeWidth: 1,
          consumeTapEvents: true,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZonDetail(index: 2,)));
          },
        ),
      );

    }

    if(countUTEM >= 5){

      _polygons.add(
        Polygon(
          polygonId: PolygonId("5"),
          points: PolygonUTEM,
          fillColor: (Colors.red.withOpacity(0.2)),
          strokeWidth: 1,
          consumeTapEvents: true,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZonDetail(index: 1,)));
          },
        ),
      );
    }
    else if(countUTEM <= 5){

      _polygons.add(
        Polygon(
          polygonId: PolygonId("6"),
          points: PolygonUTEM,
          fillColor: (Colors.green.withOpacity(0.2)),
          strokeWidth: 1,
          consumeTapEvents: true,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZonDetail(index: 1,)));
          },
        ),
      );

    }
  }
  setPolyLines(){
    setPoly();
    if(countMarkerMerbok >= 3){
      polyLines.add(Polyline(
        polylineId: PolylineId('route4'),
        visible: true,
        points: polyPoints,
        color: Colors.red,
        width: 4,
      ));

    }
    else if(countMarkerMerbok <= 2){

      polyLines.add(Polyline(
        polylineId: PolylineId('route3'),
        visible: true,
        points: polyPoints,
        color: Colors.green.withOpacity(0.2),
        width: 4,
      ));

    }

    if(countAEON >= 5){

      polyLines.add(Polyline(
        polylineId: PolylineId('route2'),
        visible: true,
        points: polyPointsZon2,
        color: Colors.red,
        width: 4,
      ));
    }
    else if(countAEON <= 4){

      polyLines.add(Polyline(
        polylineId: PolylineId('route1'),
        visible: true,
        points: polyPointsZon2,
        color: Colors.green.withOpacity(0.2),
        width: 4,
      ));

    }

  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  bool loading = false;
  @override
  void initState() {

    getCurrentLocation();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(

            backgroundColor: Colors.transparent,
            elevation: 0.0,
            //centerTitle: true,
            //title: const Text("TRASH LOCATION"),
            actions: <Widget>[
              FirebaseAuth.instance.currentUser == null
                  ? IconButton(
                icon: const Icon(
                  PhosphorIcons.sign_in,
                  size: 32.0,
                  color: Color(0xff1c1c1c),
                ),
                onPressed: () async {
                  //loading ? Loading() :await _auth.signOut();
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                  //_exitApp(context);
                  Navigator.pop(context);
                },
              )
                  :IconButton(
                icon: Icon(
                  PhosphorIcons.sign_out,
                  size: 32.0,
                  color: Color(0xff1c1c1c),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  loading ? Loading() :await _auth.signOut();
                  //_exitApp(context);
                },
              )
            ],
          ),

          body: currentLocation == null
              ? Loading()
              : GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  currentLocation!.latitude!, currentLocation!.longitude!),
              zoom: 15,
            ),
            markers: markers2,
            polylines: polyLines,
            polygons: _polygons,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

          //Init Floating Action Bubble
          floatingActionButton: FloatingActionBubble(
            // Menu items
            items: <Bubble>[

              // Floating action menu item
              Bubble(
                title:"Hide Zone",
                iconColor :Colors.white,
                bubbleColor : Colors.blue,
                icon:Icons.settings,
                titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                },
              ),
              // Floating action menu item
              Bubble(
                title:"Hide Route",
                iconColor :Colors.white,
                bubbleColor : Colors.blue,
                icon:Icons.people,
                titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
                onPress: () {

                  _animationController.reverse();
                },
              ),
              //Floating action menu item
              Bubble(
                title:"Hide Report",
                iconColor :Colors.white,
                bubbleColor : Colors.blue,
                icon:Icons.home,
                titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
                onPress: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => BottomNav()));
                  _animationController.reverse();
                },
              ),
            ],

            // animation controller
            animation: _animation,

            // On pressed change animation state
            onPress: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),

            // Floating Action button Icon color
            iconColor: Colors.blue,

            // Flaoting Action button Icon
            iconData: Icons.settings,
            backGroundColor: Colors.white,
          )
      ),
    );
  }

}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}
