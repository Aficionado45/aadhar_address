import 'package:flutter/material.dart';

class scanDoc extends StatefulWidget {
  const scanDoc();

  @override
  _scanDocState createState() => _scanDocState();
}

class _scanDocState extends State<scanDoc> {
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
                "Scan Documents",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 10),
              Icon(Icons.camera),
              SizedBox(height: 10),
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
                    Navigator.pushNamed(context, 'confirmaddress');
                  },
                  child: Text(
                    "Get Address",
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
    );
  }
}


//TODO: Impprove UI
//OCR Integration
