import 'dart:core';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/screens/report_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth.dart';
import '../shared/loading.dart';
import 'make_report.dart';
import 'details_container.dart';




class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  List<DocumentSnapshot> _data = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    int sum=0;
    FirebaseFirestore.instance
        .collection('Reports')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["ReportID"]);
        _data= querySnapshot.docs;
        print(_data.length);

        sum++;
        print(sum);
        print('ini sum');

      });
    });

    print(sum);
    print('ini sum');
  }


  void _onTileTap(DocumentSnapshot snap) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(snap: snap),
      ),
    );
  }






  final AuthService _auth = AuthService();
  List status = [
    {'name'   :'Item',
     'status' : 'In Progress'},
    {'name'   :'Item',
      'status' : 'In Progress'},
    {'name'   :'Item',
      'status' : 'Complete'},
    {'name'   :'Item',
      'status' : 'Complete'}
  ];
  Size displaySize(BuildContext context) {
    debugPrint('Size = ${MediaQuery.of(context).size}');
    return MediaQuery.of(context).size;
  }

  double displayHeight(BuildContext context) {
    debugPrint('Height = ${displaySize(context).height}');
    return displaySize(context).height;
  }

  double displayWidth(BuildContext context) {
    debugPrint('Width = ${displaySize(context).width}');
    return displaySize(context).width;
  }
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  bool loading = false;
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TRASH REPORT"),
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
            icon: const Icon(
              PhosphorIcons.sign_out,
              size: 32.0,
              color: Color(0xff1c1c1c),
            ),
            onPressed: () async {
              //Navigator.pop(context);
              loading ? Loading() :await _auth.signOut();
              //_exitApp(context);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(

                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  items:[
                    CustomCard(
                      width: MediaQuery.of(context).size.width,

                      borderRadius: 10,
                      color: Colors.lime,
                      hoverColor: Colors.indigo,
                      onTap: () {},
                      child: Column(
                        children: [
                          ColoredBox(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Zon Durian Tunggal',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Condition',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Good'),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Next Collection',
                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('12/02/2023'),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Reports',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('3',
                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),



                        ],
                      ),
                    ),

                    CustomCard(
                      width: MediaQuery.of(context).size.width,
                      borderRadius: 10,
                      color: Colors.orangeAccent,
                      hoverColor: Colors.deepOrangeAccent,
                      onTap: () {},
                      child: Column(
                        children: [
                          ColoredBox(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Zon Melaka Tengah',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Condition',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Moderate'),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Next Collection',
                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('01/02/2023'),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Reports',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('4',
                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),



                        ],
                      ),
                    ),

                    CustomCard(
                      width: MediaQuery.of(context).size.width,

                      borderRadius: 10,
                      color: Colors.lime,
                      hoverColor: Colors.indigo,
                      onTap: () {},
                      child: Column(
                        children: [
                          ColoredBox(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Zon Alor Gajah',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Condition',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Good'),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Next Collection',
                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('05/02/2023'),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Reports',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('0',
                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),



                        ],
                      ),
                    ),

                    CustomCard(
                      width: MediaQuery.of(context).size.width,

                      borderRadius: 10,
                      color: Colors.lime,
                      hoverColor: Colors.indigo,
                      onTap: () {},
                      child: Column(
                        children: [
                          ColoredBox(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Zon Jasin',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Condition',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Good'),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Next Collection',
                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('12/12/2022'),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Reports',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('3',
                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),



                        ],
                      ),
                    ),
                  ],

                  //Slider Container properties
                  options: CarouselOptions(
                    height: 137.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    //aspectRatio: 2 / 1,
                    autoPlayCurve: Curves.linear,
                    enableInfiniteScroll: false,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    viewportFraction: 1,
                    scrollDirection: Axis.horizontal,
                  ),
                  //   ),
                  // ],
                ),
              ),
            ],
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {

                        },
                        child: const Text('MELAKA TENGAH'),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {

                        },
                        child: const Text('JASIN'),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {

                        },
                        child: const Text('All'),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {

                      },
                      child: const Text('ALOR GAJAH'),
                    ),
                  ]
              )
          ),
          ColoredBox(

            color: Colors.grey,
            child: Column(
                children: <Widget>[
                  //LIST REPORTT SCROLLABLE
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Reports").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (!snapshot.hasData){
                        return Center(
                            child: CircularProgressIndicator()
                        );
                      }

                      return Container(
                        height: MediaQuery.of(context).size.height/ 2,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                            children: snapshot.data!.docs.map((snap) {
                              return Card(
                                child: InkWell(
                                  onTap: () => _onTileTap(snap),
                                  child: ListTile(
                                    leading: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      child: Image.network(snap['Evidence']),
                                    ),
                                    title: Text(snap['Deskripsi'].toString()),
                                    subtitle: Text(snap['Email'].toString()),
                                    trailing: Text(snap['Status']),
                                  ),
                                ),
                              );
                            }).toList()
                        ),
                      );



                    },
                  ),

                  // Container(
                  //
                  //   height: MediaQuery.of(context).size.height - 324,
                  //   child: ListView.builder(
                  //       shrinkWrap : true,
                  //       scrollDirection: Axis.vertical,
                  //       itemCount: 3,
                  //       itemBuilder: (context, index) {
                  //         return CustomCard(
                  //           width: MediaQuery.of(context).size.width,
                  //           height: 150,
                  //           borderRadius: 10,
                  //           color: Colors.white,
                  //           hoverColor: Colors.indigo,
                  //           onTap: () {},
                  //           child: Column(
                  //             children: [
                  //                Expanded(
                  //                  child: Row(
                  //                    children: [
                  //                      Column(
                  //                        children: [
                  //                          SizedBox(
                  //                            width: (MediaQuery.of(context).size.width / 2) + 30,
                  //                            child: Row(
                  //
                  //                             children: [
                  //                               SizedBox(
                  //                                 width: (MediaQuery.of(context).size.width / 2) + 30,
                  //
                  //                                 child: Column(
                  //                                   children: [
                  //                                     Container(
                  //                                       width: (MediaQuery.of(context).size.width / 2) + 30,
                  //                                       padding: EdgeInsets.all(5),
                  //                                       decoration: BoxDecoration(
                  //                                         color: Colors.lightGreen,
                  //                                         border: Border.all(
                  //                                           color: Colors.lightGreen,
                  //                                         ),
                  //                                         borderRadius: BorderRadius.only(
                  //                                             topRight:Radius.circular(0),
                  //                                             topLeft:Radius.circular(20),
                  //                                             bottomRight:Radius.circular(20),
                  //                                             bottomLeft:Radius.circular(0)
                  //                                         )
                  //                                       ),
                  //                                       child: Center(
                  //                                         child: Text('Zon',
                  //                                           style: TextStyle(
                  //                                               fontSize: 20,
                  //                                               fontWeight: FontWeight.bold,
                  //                                             color: Colors.white,
                  //                                           ),
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                     Row(
                  //                                       children: [
                  //                                         SizedBox(
                  //                                           width: ((MediaQuery.of(context).size.width / 2) + 30) / 3,
                  //                                           child: Center(
                  //                                             child: Text('test',
                  //                                               style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold, color: Colors.black),
                  //                                             ),
                  //                                           ),
                  //                                         ),
                  //                                         SizedBox(
                  //                                           width: ((MediaQuery.of(context).size.width / 2) + 30) / 3,
                  //
                  //
                  //                                         ),
                  //                                         SizedBox(
                  //                                           width: ((MediaQuery.of(context).size.width / 2) + 30) / 3,
                  //                                           child: Center(
                  //                                             child: Text('1/1/2023',
                  //                                               style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold, color: Colors.black),
                  //                                             ),
                  //                                           ),
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //
                  //
                  //
                  //                             ],
                  //               ),
                  //                          ),
                  //                          Row(
                  //
                  //                            children: [
                  //                              SizedBox(
                  //                                height: 10,
                  //                              ),
                  //                            ],
                  //                          ),
                  //                          Row(
                  //                            children: [
                  //                              SizedBox(
                  //                                width: ((MediaQuery.of(context).size.width / 2) + 30) / 3,
                  //                                child: ColoredBox(
                  //                                  color: Colors.blueGrey,
                  //                                  child: Container(
                  //                                    padding: EdgeInsets.all(5),
                  //                                    decoration: BoxDecoration(
                  //                                        color: Colors.lightGreen,
                  //                                        border: Border.all(
                  //                                          color: Colors.lightGreen,
                  //                                        ),
                  //                                        borderRadius: BorderRadius.only(
                  //                                            topRight:Radius.circular(20),
                  //                                            topLeft:Radius.circular(0),
                  //                                            bottomRight:Radius.circular(20),
                  //                                            bottomLeft:Radius.circular(0)
                  //                                        )
                  //                                    ),
                  //                                    child: Column(
                  //                                      children: [
                  //                                        Image(
                  //                                          image: AssetImage("lib/screens/assets/images/Catg.png"),
                  //                                          width: 20,
                  //                                          height: 20,
                  //                                          color: null,
                  //                                          fit: BoxFit.scaleDown,
                  //                                          alignment: Alignment.center,
                  //                                        )
                  //
                  //
                  //                                      ],
                  //                                    ),
                  //                                  ),
                  //                                ),
                  //                              ),
                  //                              SizedBox(
                  //                                width: (((MediaQuery.of(context).size.width / 2) + 30) / 3)*2 ,
                  //                                child: Container(
                  //                                  padding: EdgeInsets.all(6),
                  //                                  decoration: BoxDecoration(
                  //                                      color: Colors.blueGrey,
                  //                                      border: Border.all(
                  //                                        color: Colors.blueGrey,
                  //                                      ),
                  //                                      borderRadius: BorderRadius.only(
                  //                                          topRight:Radius.circular(10),
                  //                                          topLeft:Radius.circular(0),
                  //                                          bottomRight:Radius.circular(10),
                  //                                          bottomLeft:Radius.circular(0)
                  //                                      )
                  //                                  ),
                  //                                  child: Column(
                  //                                    children: [
                  //                                      Text('Dumpster',
                  //                                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  //                                      ),
                  //
                  //
                  //                                    ],
                  //                                  ),
                  //                                ),
                  //                              ),
                  //                            ],
                  //                          ),
                  //                          Row(
                  //
                  //                            children: [
                  //                              SizedBox(
                  //                                height: 5,
                  //                              ),
                  //                            ],
                  //                          ),
                  //                          Row(
                  //                            children: [
                  //                              SizedBox(
                  //                                width: ((MediaQuery.of(context).size.width / 2) + 30) / 3,
                  //                                child: ColoredBox(
                  //                                  color: Colors.blueGrey,
                  //                                  child: Container(
                  //                                    padding: EdgeInsets.all(5),
                  //                                    decoration: BoxDecoration(
                  //                                        color: Colors.lightGreen,
                  //                                        border: Border.all(
                  //                                          color: Colors.lightGreen,
                  //                                        ),
                  //                                        borderRadius: BorderRadius.only(
                  //                                            topRight:Radius.circular(20),
                  //                                            topLeft:Radius.circular(0),
                  //                                            bottomRight:Radius.circular(20),
                  //                                            bottomLeft:Radius.circular(0)
                  //                                        )
                  //                                    ),
                  //                                    child: Column(
                  //                                      children: [
                  //                                        Image(
                  //                                          image: AssetImage("lib/screens/assets/images/Inf.png"),
                  //                                          width: 20,
                  //                                          height: 20,
                  //                                          color: null,
                  //                                          fit: BoxFit.scaleDown,
                  //                                          alignment: Alignment.center,
                  //                                        )
                  //
                  //
                  //                                      ],
                  //                                    ),
                  //                                  ),
                  //                                ),
                  //                              ),
                  //                              SizedBox(
                  //                                width: (((MediaQuery.of(context).size.width / 2) + 30) / 3)*2 ,
                  //                                child: Container(
                  //                                  padding: EdgeInsets.all(6),
                  //                                  decoration: BoxDecoration(
                  //                                      color: Colors.blueGrey,
                  //                                      border: Border.all(
                  //                                        color: Colors.blueGrey,
                  //                                      ),
                  //                                      borderRadius: BorderRadius.only(
                  //                                          topRight:Radius.circular(10),
                  //                                          topLeft:Radius.circular(0),
                  //                                          bottomRight:Radius.circular(10),
                  //                                          bottomLeft:Radius.circular(0)
                  //                                      )
                  //                                  ),
                  //                                  child: Column(
                  //                                    children: [
                  //                                      Text('Dumpster',
                  //                                        style: TextStyle(fontSize: 15),
                  //                                      ),
                  //
                  //
                  //                                    ],
                  //                                  ),
                  //                                ),
                  //                              ),
                  //                            ],
                  //                          ),
                  //                        ],
                  //                      ),
                  //                      Column(
                  //                        children: [
                  //                          SizedBox(
                  //                            width: 10,
                  //
                  //
                  //                          ),
                  //                        ],
                  //                      ),
                  //                      Column(
                  //                        children: [
                  //                          Row(
                  //
                  //
                  //                            children: [
                  //
                  //
                  //                              SizedBox(
                  //                                width: (MediaQuery.of(context).size.width / 2) - 58,
                  //                                child: Column(
                  //
                  //
                  //                                  children: [
                  //                                    Container(
                  //                                      padding: EdgeInsets.all(5),
                  //                                      decoration: BoxDecoration(
                  //                                          border: Border.all(
                  //                                            color: Colors.white,
                  //
                  //                                          ),
                  //                                          borderRadius: BorderRadius.all(Radius.circular(20))
                  //                                      ),
                  //                                      child: Row(
                  //                                        mainAxisAlignment: MainAxisAlignment.center,
                  //                                        children: const [
                  //                                          Text('Status : ',
                  //                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  //                                          ),
                  //                                           Image(
                  //                                            image: AssetImage("lib/screens/assets/images/UnderReviewIcon.png"),
                  //                                            width: 20,
                  //                                            height: 20,
                  //                                            color: null,
                  //                                            fit: BoxFit.scaleDown,
                  //                                            alignment: Alignment.center,
                  //                                          )
                  //                                        ],
                  //                                      ),
                  //                                    ),
                  //
                  //
                  //
                  //                                  ],
                  //                                ),
                  //                              ),
                  //
                  //                            ],
                  //                          ),
                  //                          Row(
                  //
                  //
                  //                            children: [
                  //
                  //
                  //                              SizedBox(
                  //
                  //                                height: 5,
                  //
                  //                              ),
                  //
                  //                            ],
                  //                          ),
                  //                          Row(
                  //
                  //                            mainAxisAlignment: MainAxisAlignment.center,
                  //                            children: [
                  //
                  //
                  //                              SizedBox(
                  //                                width: (MediaQuery.of(context).size.width / 2) - 58,
                  //
                  //                                child: ColoredBox(
                  //                                  color: Colors.red,
                  //                                  child: Image(
                  //                                    image: const AssetImage("lib/screens/assets/images/Dumpster.png"),
                  //                                    width: (MediaQuery.of(context).size.width / 2) - 78,
                  //                                    height: 90,
                  //
                  //
                  //                                  )
                  //                                ),
                  //                              ),
                  //
                  //                            ],
                  //                          ),
                  //                        ],
                  //                      ),
                  //                    ],
                  //                  ),
                  //                ),
                  //             ],
                  //           ),
                  //         );
                  //       }),
                  // )
                ]
            ),
          )

        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MakeReport())
          );
        },
        child: const Icon(Icons.report),
      ),




    );

    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         StreamBuilder(
    //           stream: FirebaseFirestore.instance.collection("Reports").snapshots(),
    //           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    //             if (!snapshot.hasData){
    //               return Center(
    //                   child: CircularProgressIndicator()
    //               );
    //             }
    //
    //             return Container(
    //               height: MediaQuery.of(context).size.height/ 2,
    //               width: MediaQuery.of(context).size.width,
    //               child: ListView(
    //                   children: snapshot.data!.docs.map((snap) {
    //                     return Card(
    //                       child: ListTile(
    //                         //leading: Text(snap['age'].toString()),
    //                         leading: Image.network(snap['Evidence']),
    //                         title: Text(snap['Deskripsi'].toString()),
    //                         subtitle: Text(snap['Email'].toString()),
    //
    //
    //                         trailing: Text(snap['Status']),
    //                       ),
    //                     );
    //                   }).toList()
    //               ),
    //             );
    //           },
    //         ),
    //         SizedBox(height: 30,),
    //
    //
    //       ],
    //     ),
    //   ),
    // );



  }
}
