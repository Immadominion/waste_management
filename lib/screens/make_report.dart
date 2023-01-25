import 'dart:io';

import 'package:camera/camera.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';





class MakeReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreen();
  }
}

class _HomeScreen extends State<MakeReport> {

  // initialize firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;



// new code //



// Text box punya controller
  TextEditingController _controller=TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //generate random nombor utk report id
  Random random = new Random();

  //tukar asset ke file

  // Future<File> getAssetFile() async {
  //  const String assetPath ='assets/images/pleaseuploadlogo.png';
  //   final byteData = await rootBundle.load(assetPath);
  //   final tempDir = await getTemporaryDirectory();
  //   final file = File('${tempDir.path}/$assetPath');
  //   await file.writeAsBytes(byteData.buffer.asUint8List());
  //   return file;
  // }



  // initialize dummy
  File _imageFile= File('test.file');
  // String _uploadedFileURL='https://ik.imagekit.io/oz8zyveub/1156518-200.png?ik-sdk-version=javascript-1.4.3&updatedAt=1673858081392' ;
  String _uploadedFileURL= "";
  bool updateImg = false; // set state image lom update

  Future<void> _uploadFirestore(String photoUrl) async {



    User? user = await _auth.currentUser;
    String? email = "";



    if (user != null) {


      email = user.email;


        print(email);
        print('this is email');


    }



    //get user position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // insert data to firestore
    _firestore.collection("/Reports").add({
      "ReportID": "Report ${random.nextInt(100)}" ,
      "Evidence": photoUrl,
      "Lokasi": GeoPoint(position.latitude,position.longitude),
      "Status": "Pending",
      "Date": Timestamp.now(),
      "Deskripsi": _controller.text,
      "Zon": "3",
      "Email": email,
      "Reason":"Not yet reviewed",

      // add more fields as needed
    });



  }

  //amik image
  Future<void> _pickImage(ImageSource source) async {

      final File imageFile = await ImagePicker.pickImage(source: source);



      setState(() {


        _imageFile = imageFile;
        updateImg = true;
      });

    }






  Future<void> _uploadImage() async {
  if (_imageFile != null) {
    Reference reference = _storage.ref().child('images/${_imageFile.path.split("/").last}');
    UploadTask uploadTask = reference.putFile(_imageFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
  _uploadedFileURL = await storageTaskSnapshot.ref.getDownloadURL();
  _uploadFirestore(_uploadedFileURL);
  setState(() {});
  }
  }



  bool _isUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                width: 200,
                height: 200,
                child: updateImg
                    ? Image.file(_imageFile)
                    : Center(child: Text("Choose Photo From Gallery",))
            ),


            ElevatedButton.icon(
              icon: Icon(Icons.photo_library),
              label: Text('Choose from Gallery'),

              onPressed: () => _pickImage(ImageSource.gallery),
            ),
            Container(
              width: 100,
              height: 100,
            ),
            TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter Report Details',
                  border: OutlineInputBorder(),
                )
            ),
            if (_imageFile != null) ...[
              ElevatedButton.icon(
                icon: Icon(Icons.done),
                label: Text('Submit Report'),
                onPressed: () {
                  _uploadImage();
                  setState(() {
                    _isUploaded = true;
                  });
                },
              ),
            ],
            if (_isUploaded)
              Text(" Report Successfully Submitted! Thank You for your concern!"),
          ],
        ),
      ),
    );
  }


}