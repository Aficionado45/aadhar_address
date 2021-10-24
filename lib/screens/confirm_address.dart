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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        Navigator.pushNamed(context, 'scan');
                      },
                      child: Text(
                        "Scan Again",
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
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: Improve UI
//Show OCR Result with scanned address and cropped document image 
//Verify extracted location with GPS location in a limit of 300m
//Show Error on wrong location verification
//User will be given a countdown of 1 min to press confirm or reset 
//If user confirms store scanned image in storage and update the ongoing document step, timestamp, pincode and scanned_address field