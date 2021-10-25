import 'package:aadhar_address/screens/scan.dart';
import 'package:aadhar_address/screens/user_login.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class capture extends StatefulWidget {
  const capture();

  @override
  _captureState createState() => _captureState();
}

// Pick image from camera
Future pickImageFromCamera(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  try {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: MediaQuery.of(context).size.height / 4,
      maxWidth: MediaQuery.of(context).size.height / 3.5,
    );
    return pickedFile;
  } catch (err) {
    print(err);
  }
}

// Upload image file to destination on Firebase Storage
// : if request.auth != null;
Future<void> uploadImage(File image, String storageDestinationPath) async {
  try {
    await FirebaseStorage.instance.ref(storageDestinationPath).putFile(image);
  } on FirebaseException catch (err) {
    print(err.toString());
  }
}

class _captureState extends State<capture> {
  File userImage;
  File operatorImage;
  bool userUploaded = false;
  bool operatorUploaded = false;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Capture User and operator Images",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      userUploaded
                          ? Image(
                              image: FileImage(
                                userImage,
                              ),
                            )
                          : Icon(
                              Icons.person_outline_rounded,
                              size: MediaQuery.of(context).size.height / 10,
                            ),
                      Text(
                        'User',
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF143B40),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        alignment: FractionalOffset.center,
                        width: MediaQuery.of(context).size.width / 5,
                        height: 25,
                        child: FlatButton(
                          onPressed: () async {
                            final PickedFile newImage =
                                await pickImageFromCamera(context);
                            setState(() {
                              if (newImage != null) {
                                userImage = File(newImage.path);
                                userUploaded = true;
                              }
                            });
                          },
                          child: Text(
                            "Capture",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      operatorUploaded
                          ? Image(
                              image: FileImage(
                                operatorImage,

                              ),
                            )
                          : Icon(
                              Icons.person_outline_rounded,
                              size: MediaQuery.of(context).size.height / 10,
                            ),
                      Text(
                        'Operator',
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF143B40),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        alignment: FractionalOffset.center,
                        width: MediaQuery.of(context).size.width / 5,
                        height: 25,
                        child: FlatButton(
                          onPressed: () async {
                            final PickedFile newImage =
                                await pickImageFromCamera(context);
                            setState(() {
                              if (newImage != null) {
                                operatorImage = File(newImage.path);
                                operatorUploaded = true;
                              }
                            });
                          },
                          child: Text(
                            "Capture",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF143B40),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    alignment: FractionalOffset.center,
                    width: MediaQuery.of(context).size.width / 4,
                    height: 40,
                    child: FlatButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, 'capture');
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF143B40),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    alignment: FractionalOffset.center,
                    width: MediaQuery.of(context).size.width / 4,
                    height: 40,
                    child: FlatButton(
                      onPressed: () async {
                        if (userUploaded && operatorUploaded) {
                          await uploadImage(userImage, '$user_aadhar/user.png');
                          await uploadImage(
                              operatorImage, '$user_aadhar/operator.png');
                          Navigator.pushNamed(context, "confirm");
                        }
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


//TODO: Improve UI
//Show Error messages