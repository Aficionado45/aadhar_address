import 'package:aadhar_address/utils/feedback_form.dart';
import 'package:flutter/material.dart';

class recipt extends StatefulWidget {
  const recipt();

  @override
  _reciptState createState() => _reciptState();
}

class _reciptState extends State<recipt> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF143B40),
          child: Icon(
            Icons.help_outline_rounded,
          ),
          onPressed: () async{
            getFeedback(context);
          },
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Final generated Recipt of the update"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                          print("Shared");
                        },
                        child: Text(
                          "Share",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
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
                          Navigator.pushNamed(context, 'oplogin');
                        },
                        child: Text(
                          "Finish",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: Improve UI
//Implement share and feedback option
//Clear all existing variables