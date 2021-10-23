import 'package:flutter/material.dart';

class userLogin extends StatefulWidget {
  const userLogin();

  @override
  _userLoginState createState() => _userLoginState();
}

class _userLoginState extends State<userLogin> {
  @override
  String user_aadhar;

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
                    user_aadhar = value;
                    print(user_aadhar);
                  }
                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  labelText: "Enter User Aadhar Number",
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
                  if (user_aadhar != null && user_aadhar.length == 12) {
                    print("pressed");
                    Navigator.pushNamed(context, 'userotp');
                  }
                },
                child: Text(
                  "Get OTP",
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
