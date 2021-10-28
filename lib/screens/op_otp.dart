
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class opOTP extends StatefulWidget {
  const opOTP();

  @override
  _opOTPState createState() => _opOTPState();
}

class _opOTPState extends State<opOTP> {
  @override
  String otp;
  bool error = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height/8,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width/4,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Hero(
            tag: 'logo',
            child: Image(
              image: AssetImage('images/Aadhaar_Logo.svg'),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              margin: EdgeInsets.all(50),
              child: OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                style: TextStyle(
                    fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Open Sans'
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: MediaQuery.of(context).size.width / 10,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  otp = pin;
                  print("Completed: " + pin);
                },
                otpFieldStyle: OtpFieldStyle(
                  borderColor: Colors.grey,
                  focusBorderColor: Colors.black
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF143B40),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              alignment: FractionalOffset.center,
              width: MediaQuery.of(context).size.width / 3.0,
              height: 40,
              child: FlatButton(
                onPressed: () {
                  if (otp != null) {
                    setState(() {
                      error = false;
                    });
                    print("pressed");
                    Navigator.pushNamed(context, 'userlogin');
                  }
                  else{
                    setState(() {
                      error = true;
                    });
                  }
                },
                child: Text(
                  "Enter OTP",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold
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
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 12,)
          ],
        ),
      ),
    );
  }
}


//TODO: Improve UI
//Error for wrong otp and resend option
////API integration