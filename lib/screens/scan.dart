import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum AppState {
  free,
  picked,
  cropped,
  extracted
}

class scanDoc extends StatefulWidget {
  const scanDoc();

  @override
  _scanDocState createState() => _scanDocState();
}

class _scanDocState extends State<scanDoc> {
  AppState state;
  File _image;
  //Initial image contains the initial file
  File _initialImage;
  TextEditingController script = TextEditingController();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                script.text != null
                    ? Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: TextFormField(
                    controller: script,
                    minLines: 5,
                    maxLines: 100,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                )
                    : Text("No Text found"),
                SizedBox(height: 20),
                SizedBox(height: 10),
                Icon(Icons.camera),
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
                if (state == AppState.picked|| state == AppState.extracted)
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
                        "Crop Again",
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
                      onPressed: () {
                        Navigator.pushNamed(context, 'confirmaddress');
                      },
                      child: Text(
                        "Confirm Address and Proceed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
              ],
            ),
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
        _initialImage=_image;
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
