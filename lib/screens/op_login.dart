import 'package:aadhar_address/screens/op_otp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('operator');
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
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
                  onPressed: () async {
                    bool exists = await checkIfDocExists(op_aadhar);
                    if (op_aadhar != null && op_aadhar.length == 12 && exists) {
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
      ),
    );
  }
}


//TODO: Improve UI 
//add error for wrong inputs(Less than 12 digits / wrong operator aadhar no.)
//Auth API integeation