import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZonDetail extends StatefulWidget {
  int index;
  ZonDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<ZonDetail> createState() => _ZonDetailState();
}

class _ZonDetailState extends State<ZonDetail> {





   void getZonDetail() async{
    final CollectionReference _products = FirebaseFirestore.instance.collection('Dumpster');
    final Query unapproved = _products.where("Zone", isEqualTo: widget.index);


    //final CollectionReference noticeCollection=FirebaseFirestore.instance.collection('Dumpster');
    //final Query unapproved = noticeCollection.where("Zone", isEqualTo: widget.index);


  }

   final CollectionReference _products = FirebaseFirestore.instance.collection('Dumpster');
  @override
  void initState() {

    //getZonDetail();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Zon ${widget.index}"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:  FirebaseFirestore.instance.collection('Dumpster').where('Zone', isEqualTo: widget.index.toString()).snapshots(), //build connection
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,  //number of rows
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['DumpsterID']),
                    subtitle: Text(documentSnapshot['Status']),

                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )


    );
  }
}
