import 'dart:io';

import 'package:aadhar_address/screens/capture.dart';
import 'package:aadhar_address/screens/confirm_address.dart';
import 'package:aadhar_address/screens/user_login.dart';
import 'package:aadhar_address/utils/feedback_form.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AppState { free, picked, cropped, extracted }

class scanDoc extends StatefulWidget {
  const scanDoc();

  @override
  _scanDocState createState() => _scanDocState();
}

String address;

class _scanDocState extends State<scanDoc> {
  AppState state;
  File _image;
  bool error = false;

  //Initial image contains the initial file
  File _initialImage;
  TextEditingController script = TextEditingController();
  final picker = ImagePicker();

  void updateData() {
    var db = FirebaseFirestore.instance;
    address = script.text;
    DateTime curr = DateTime.now();
    db.collection("ongoing").doc(userRefId).update({
      "step": 2,
      "timestamp": curr,
    });
    db.collection("ongoing").doc(userRefId).set({
      "scanned_address": address,
      "step": 2,
      "timestamp": curr,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: MediaQuery.of(context).size.height / 8,
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width / 4,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Hero(
              tag: 'logo',
              child: Image(
                image: AssetImage('images/Aadhaar_Logo.svg'),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.help_outline_rounded,
                color: Color(0xFF143B40),
                size: 30,
              ),
              onPressed: () {
                getFeedback(context);
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                "Scan Documents",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 20),
              _image == null
                  ? Text(
                      'No image selected.',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  : Container(
                      height: 300, width: 300, child: Image.file(_image)),
              SizedBox(height: 20),
              if (state == AppState.extracted)
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: script,
                    minLines: 5,
                    maxLines: 100,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (val) {
                      setState(() {});
                    },
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                  ),
                ),
              if (state == AppState.free)
                Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                          color: Colors.grey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Capture and upload a document",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 30)),
                                Icon(Icons.camera),
                              ])),
                    )),
              SizedBox(height: 20),
              SizedBox(height: 10),
              SizedBox(height: 10),
              if (state == AppState.free)
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF143B40),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  alignment: FractionalOffset.center,
                  width: MediaQuery.of(context).size.width / 3,
                  height: 40,
                  child: FlatButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text(
                      "Capture Pic",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              if (state == AppState.picked || state == AppState.extracted)
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF143B40),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  alignment: FractionalOffset.center,
                  width: MediaQuery.of(context).size.width / 3,
                  height: 40,
                  child: FlatButton(
                    onPressed: () {
                      cropImage();
                    },
                    child: Text(
                      "Crop Document",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              if (state == AppState.picked || state == AppState.extracted)
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF143B40),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  alignment: FractionalOffset.center,
                  width: MediaQuery.of(context).size.width / 3,
                  height: 40,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        state = AppState.cropped;
                      });
                      getText();
                    },
                    child: Text(
                      "Extract address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              if (state == AppState.extracted)
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF143B40),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  alignment: FractionalOffset.center,
                  width: MediaQuery.of(context).size.width / 3,
                  height: 80,
                  child: FlatButton(
                    onPressed: () async {
                      //Line is commented out for testing
                      await uploadImage(
                          _initialImage, '$userRefId/document.png');
                      updateData();
                      Navigator.push(
                        context,
                        //AS A PARAMTER SEND UR ADDRESS for testing, ELSE we will have to send the extracted address i.e script.text
                        MaterialPageRoute(
                          builder: (context) =>
                              cnfrmAddress(address: script.text),
                        ),
                      );
                      // "34AROY M.C LAHIRI STREET ganesh apart ment, Chatra, Serampore, West Bengal 712204, India",
                    },
                    child: Text(
                      "Confirm Address and Proceed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              Spacer(),
              Text(
                'Invalid OTP',
                style: TextStyle(
                    color: error ? Colors.red : Colors.white,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  //Operator captures document from camera
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _initialImage = _image;
        setState(() {
          state = AppState.picked;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Null> cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop the Image',
            toolbarColor: Color(0xff375079),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
      });
    }
  }

  //Reading address
  void getText() async {
    await readText(_image);
    setState(() {
      state = AppState.extracted;
    });
  }

  Future readText(File image) async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(image);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    script.clear();
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            script.text = script.text + " " + word.text;
          });
        }
        script.text = script.text + '\n';
      }
    }
    setState(() {});
  }
}

//TODO: Impprove UI
//OCR Integration
//Line 40
