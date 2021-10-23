import 'package:aadhar_address/screens/op_otp.dart';
import 'package:flutter/material.dart';
import 'package:aadhar_address/screens/op_otp.dart';

class opLogin extends StatefulWidget {
  const opLogin();

  @override
  _opLoginState createState() => _opLoginState();
}

class _opLoginState extends State<opLogin> {
  @override
  String op_aadhar;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 13.6,
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.blue,
                ),
                onChanged: (value) {
                  if (value.isEmpty)
                    return null;
                  else {
                    op_aadhar = value;
                    print(op_aadhar);
                  }
                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  labelText: "Enter Operator Aadhar Number",
                ),
              ),
            ),
            SizedBox(height: 30),
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
                  if (op_aadhar != null && op_aadhar.length == 12) {
                    print("pressed");
                    Navigator.pushNamed(context, 'opotp');
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
