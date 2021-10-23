import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class userOTP extends StatefulWidget {
  const userOTP();

  @override
  _userOTPState createState() => _userOTPState();
}

class _userOTPState extends State<userOTP> {
  @override
  String otp;
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(50),
                child: OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  style: TextStyle(fontSize: 15),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    otp = pin;
                    print("Completed: " + pin);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF143B40),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                alignment: FractionalOffset.center,
                width: MediaQuery.of(context).size.width / 3.5,
                height: 40,
                child: FlatButton(
                  onPressed: () {
                    if (otp != null) {
                      print("pressed");
                      Navigator.pushNamed(context, 'scan');
                    }
                  },
                  child: Text(
                    "Enter OTP",
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
      ),
    );
  }
}
