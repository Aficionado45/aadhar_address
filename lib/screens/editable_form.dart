import 'package:flutter/material.dart';

class editForm extends StatefulWidget {
  const editForm();
  @override
  _editFormState createState() => _editFormState();
}

class _editFormState extends State<editForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
