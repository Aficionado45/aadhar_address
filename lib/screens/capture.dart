import 'package:aadhar_address/screens/scan.dart';
import 'package:flutter/material.dart';

class capture extends StatefulWidget {
  const capture();

  @override
  _captureState createState() => _captureState();
}

class _captureState extends State<capture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Capture User and operator Images"),
            Text("and upload them to storage"),
            SizedBox(
              height: 10,
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
                onPressed: () {
                  Navigator.pushNamed(context, "confirm");
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
        ),
      ),
    );
  }
}
