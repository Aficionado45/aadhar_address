import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen();

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/Aadhaar_Logo.svg'),
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Center(
                  child: Text('Aadhaar Address App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Zen'
                        // fontFamily: 'Open Sans'
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF143B40),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  alignment: FractionalOffset.center,
                  width: 110,
                  height: 40,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'oplogin');
                    },
                    child: Text(
                      "Get Started",
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


//TODO: Improve UI