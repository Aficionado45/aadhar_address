import 'package:aadhar_address/screens/capture.dart';
import 'package:aadhar_address/screens/op_login.dart';
import 'package:aadhar_address/screens/user_login.dart';
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
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Address Update Confirmation",
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'User Aadhaar No: $user_aadhar',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.6,
                            ),
                            SizedBox(height: 20,),
                            Container(
                              child: Text(
                                'Operator Aadhaar No: XXXXXXXX${op_aadhar.substring(8)}',
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.6,
                            ),
                            SizedBox(height: 20,),
                            Container(
                              child: Text(
                                'Date of update: ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.6,
                            ),
                            SizedBox(height: 20,),
                            Container(
                              child: Text(
                                'Captured Address: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.6,
                            ),
                            SizedBox(height: 20,),
                            Container(
                              child: Text(
                                'Modified Address: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.6,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Image(
                              image: FileImage(
                                userImage,
                              ),
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Text(
                              'User',
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Image(
                              image: FileImage(
                                operatorImage,
                              ),
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Operator',
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Image(
                              image: FileImage(
                                operatorImage,
                              ),
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Uploaded\nDocument',
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
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
                  Spacer(),
                  SizedBox(height: 30,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//TODO: Improve UI
//On reset line 39 and on confirm update the ongoing doc step and timestamp.