import 'package:flutter/material.dart';

class editForm extends StatefulWidget {
  const editForm();
  @override
  _editFormState createState() => _editFormState();
}

class _editFormState extends State<editForm> {
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
                Text("Editable Form for adding Small Changes"),
                Text("Confirm changed address with live location and"),
                Text("Origianlly retrived address form document"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF143B40),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  alignment: FractionalOffset.center,
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 40,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "capture");
                    },
                    child: Text(
                      "Proceed",
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


//TODO: Make editable form with extracted address giving only one top editable field to add house no., flat no. etc
//Improve UI
//On pressing proceed check updated address with original address and current GPS location
//Show Error on failure 
//If passed update the ongoing document step, timestamp and updated_address field