import 'package:aadhar_address/screens/editable_form.dart';
import 'package:aadhar_address/screens/user_login.dart';
import 'package:aadhar_address/services/authentication_methods.dart';
import 'package:aadhar_address/utils/feedback_form.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class userOTP extends StatefulWidget {
  const userOTP({this.aadharno, this.txnid, this.step});

  final String txnid, aadharno;
  final int step;

  @override
  _userOTPState createState() => _userOTPState();
}

class _userOTPState extends State<userOTP> {
  @override
  String otp;
  bool error = false;
  int pin;
  String address;
  String modAdd;
  bool isAsync = false;

  Future<void> getData() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('ongoing')
        .doc(userRefId)
        .get();
    pin = ds.get('pincode');
    address = ds.get('scanned_address');
    modAdd = ds.get('updated_address');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height / 8,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width / 4,
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
            onPressed: () {
              getFeedback(context);
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isAsync,
        child: Container(
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
                      fontFamily: 'Open Sans'),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: MediaQuery.of(context).size.width / 10,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    if (pin.isNotEmpty) otp = pin;
                    print("Completed: " + pin);
                  },
                  otpFieldStyle: OtpFieldStyle(
                      borderColor: Colors.grey, focusBorderColor: Colors.black),
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
                  onPressed: () async {
                    print(widget.step);
                    if (otp != null) {
                      setState(() {
                        error = false;
                        isAsync = true;
                      });
                      bool isValidated =
                          await validateOTP(widget.aadharno, otp, widget.txnid);
                      if (isValidated) {
                        setState(() {
                          isAsync = false;
                        });
                        switch (widget.step) {
                          case 0:
                            Navigator.pushNamed(context, 'scan');
                            break;
                          case 1:
                            Navigator.pushNamed(context, 'scan');
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => editForm(address: address),
                              ),
                            );
                            break;
                          case 3:
                            Navigator.pushNamed(context, 'capture');
                            break;
                          case 4:
                            Navigator.pushNamed(context, 'confirm');
                        }
                      } else {
                        setState(() {
                          error = true;
                          isAsync = false;
                        });
                      }
                    } else {
                      setState(() {
                        error = true;
                        isAsync = false;
                      });
                    }
                  },
                  child: Text(
                    "Enter OTP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 30,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Invalid OTP',
                style: TextStyle(
                    color: error ? Colors.red : Colors.white,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold),
              ),
              Image(
                image: AssetImage('images/Progress0.png'),
                width: MediaQuery.of(context).size.width * 0.67,
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
