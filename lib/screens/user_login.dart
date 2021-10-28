import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class userLogin extends StatefulWidget {
  const userLogin();

  @override
  _userLoginState createState() => _userLoginState();
}

String user_aadhar;

class _userLoginState extends State<userLogin> {

  bool error = false;

  @override
  Future<int> checkIfDocExists(String docId) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('ongoing');
      var doc = await collectionRef.doc(docId).get();
      if (doc.exists) {
        int step = doc.get('step');
        return step;
      } else
        return 0;
    } catch (e) {
      throw e;
    }
  }

  void addUser(String id) {
    var db = FirebaseFirestore.instance;
    DateTime curr = DateTime.now();
    db.collection("ongoing").doc(id).set({
      "step": 1,
      "aadhar": id,
      "timestamp": curr,
    });
  }

  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
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
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
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
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 20,
                  ),
                  onChanged: (value) {
                    if (value.isEmpty)
                      return null;
                    else {
                      user_aadhar = value;
                      print(user_aadhar);
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(
                        // color: Colors.redAccent,
                          width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(
                        // color: Colors.redAccent,
                          width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    labelText: "User Aadhaar Number",
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
                width: MediaQuery.of(context).size.width / 3.5,
                height: 40,
                child: FlatButton(
                  onPressed: () async {
                    int step = await checkIfDocExists(user_aadhar);
                    if (step == 0) {
                      addUser(user_aadhar);
                    }
                    if (user_aadhar != null && user_aadhar.length == 12) {
                      setState(() {
                        error = false;
                      });
                      Navigator.pushNamed(context, 'userotp', arguments: step);
                    }
                    else{
                      setState(() {
                        error = true;
                      });
                    }
                  },
                  child: Text(
                    "Get OTP",
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
                'Please enter a valid 12 digit Aadhaar Number',
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
      ),
    );
  }
}


//TODO: Improve UI
//Error for wrong input format less than 12 digits 
//Auth API integration