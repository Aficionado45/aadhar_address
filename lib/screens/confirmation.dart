import 'package:aadhar_address/utils/feedback_form.dart';
import 'package:flutter/material.dart';

class confirm extends StatefulWidget {
  const confirm();

  @override
  _confirmState createState() => _confirmState();
}

class _confirmState extends State<confirm> {
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
                Text("Final confirmation Screen with all the details"),
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
                          Navigator.pushNamed(context, 'scan');
                          //Delete the current document and start a new one at step 1
                        },
                        child: Text(
                          "Reset",
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
                          Navigator.pushNamed(context, 'biometric');
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
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
//On reset line 39 and on confirm update the ongoing doc step and timestamp.