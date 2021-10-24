import 'package:flutter/material.dart';

class biometric extends StatefulWidget {
  const biometric();

  @override
  _biometricState createState() => _biometricState();
}

class _biometricState extends State<biometric> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("User and operator Biometric Verification"),
                SizedBox(
                  height: 20,
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
                      Navigator.pushNamed(context, 'recipt');
                    },
                    child: Text(
                      "Verify",
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
      ),
    );
  }
}

//API Integration
//Improve UI
//On failure error messages and on success shift the document from ongoing to completed