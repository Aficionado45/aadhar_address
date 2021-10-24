import 'package:flutter/material.dart';

class cnfrmAddress extends StatefulWidget {
  const cnfrmAddress();

  @override
  _cnfrmAddressState createState() => _cnfrmAddressState();
}

class _cnfrmAddressState extends State<cnfrmAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Show the scanned document and"),
              Text("Address read through OCR and ask for confirmation"),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF143B40),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                alignment: FractionalOffset.center,
                width: MediaQuery.of(context).size.width / 2.5,
                height: 40,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'form');
                  },
                  child: Text(
                    "Confirm Address",
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
