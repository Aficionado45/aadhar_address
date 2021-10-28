import 'package:aadhar_address/utils/feedback_form.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class userOTP extends StatefulWidget {
  const userOTP();

  @override
  _userOTPState createState() => _userOTPState();
}

class _userOTPState extends State<userOTP> {
  @override
  String otp;
  bool error = false;

  Widget build(BuildContext context) {
    final step = ModalRoute.of(context).settings.arguments;

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.help_outline_rounded,
              color: Color(0xFF143B40),
              size: 30,
            ),
            onPressed: (){
              getFeedback(context);
            },
          )
        ],
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
                    print(step);
                    setState(() {
                      error = false;
                    });
                    switch (3) {
                      case 0:
                        Navigator.pushNamed(context, 'scan');
                        break;
                      case 1:
                        Navigator.pushNamed(context, 'scan');
                        break;
                      case 2:
                        Navigator.pushNamed(context, 'form');
                        break;
                      case 3:
                        Navigator.pushNamed(context, 'capture');
                        break;
                      case 4:
                        Navigator.pushNamed(context, 'confirm');
                    }
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
//Wrong OTP and resend
//Auth API integration