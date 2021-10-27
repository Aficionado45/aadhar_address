import 'package:aadhar_address/services/locationmethods.dart';
import 'package:aadhar_address/utils/feedback_form.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

enum AppState { free, comparedlocation, unsuccessful }

class editForm extends StatefulWidget {
  const editForm({this.address});

  final String address;

  @override
  _editFormState createState() => _editFormState();
}

class _editFormState extends State<editForm> {
  //address.text contains address
  //pinfield.text contains pin code

  TextEditingController addressfield = new TextEditingController();
  TextEditingController pinfield = new TextEditingController();
  AppState state = AppState.free;
  //_distanceinmeters contain distance between editable form address and present gps loc
  //_distanceinmeters2 contain distance between ocr address and present gps loc
  double _distanceinmeters2, _distanceinmeters;
  Location location = Location();
  bool editable = true;

  @override
  void initState() {
    addressfield.text = widget.address;
  }

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
          onPressed: () async {
            getFeedback(context);
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Editable Form for adding Small Changes"),
                Text("Confirm changed address with live location and"),
                Text("Origianlly retrived address form document"),
                TextFormField(
                  controller: addressfield,
                  readOnly: !editable,
                  minLines: 5,
                  maxLines: 100,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (val) {
                    setState(() {});
                  },
                  decoration: new InputDecoration(
                    labelText: "Edit Address",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: pinfield,
                  readOnly: !editable,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (val) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: "Enter PIN Code",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                ),
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
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 40,
                      child: FlatButton(
                        onPressed: () async {
                          //comparing editable form address with location
                          _distanceinmeters =
                              await getlocation(addressfield.text);
                          //comparing ocr address with location
                          _distanceinmeters2 =
                              await getlocation(widget.address);
                          print(_distanceinmeters);
                          setState(() {
                            state = _distanceinmeters > 300&&_distanceinmeters2>300
                                ? AppState.unsuccessful
                                : AppState.comparedlocation;
                            editable = false;
                          });
                        },
                        child: Text(
                          "Get GPS Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    if (state == AppState.comparedlocation)
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF143B40),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        alignment: FractionalOffset.center,
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 40,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'capture');
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
                if (state == AppState.comparedlocation)
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF143B40),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    alignment: FractionalOffset.center,
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 40,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          state = AppState.free;
                          editable = true;
                        });
                      },
                      child: Text(
                        "Edit Again",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                if (_distanceinmeters != null)
                  Text(
                    "Discrepancy: $_distanceinmeters meters",
                    textAlign: TextAlign.center,
                  ),
                if (state == AppState.unsuccessful && _distanceinmeters>300)
                  Text(
                    "The Distance between the address you edited in the textfield and the address otained from GPS is more than 300 metres. Reset and try again",
                    textAlign: TextAlign.center,
                  ),
                if (state == AppState.unsuccessful && _distanceinmeters2>300)
                  Text(
                    "The Distance between the address received from OCR extraction and the address otained from GPS is more than 300 metres. Reset and try again",
                    textAlign: TextAlign.center,
                  ),
                if (state == AppState.comparedlocation)
                  Text(
                    "Location verified using GPS. Now you can confirm the address and proceed",
                    textAlign: TextAlign.center,
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
