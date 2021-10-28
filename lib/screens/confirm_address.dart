
import 'package:aadhar_address/screens/editable_form.dart';
import 'package:aadhar_address/services/locationmethods.dart';
import 'package:aadhar_address/utils/feedback_form.dart';
import 'package:flutter/material.dart';

enum AppState { free, comparedlocation, unsuccessful }

class cnfrmAddress extends StatefulWidget {
  const cnfrmAddress({this.address});

  final String address;

  @override
  _cnfrmAddressState createState() => _cnfrmAddressState();
}

class _cnfrmAddressState extends State<cnfrmAddress> {
  AppState state = AppState.free;
  double _distanceinmeters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.address,
                textAlign: TextAlign.center,
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
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, 'scan');
                      },
                      child: Text(
                        "Scan Again",
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
                  if (state == AppState.free)
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
                          _distanceinmeters = await getlocation(widget.address);
                          print(_distanceinmeters);
                          setState(() {
                            state = _distanceinmeters > 300
                                ? AppState.unsuccessful
                                : AppState.comparedlocation;
                          });
                        },
                        child: Text(
                          "Get Location",
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  editForm(address: widget.address),
                            ),
                          );
                        },
                        child: Text(
                          "Confirm Address",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )
                ],
              ),
              if (_distanceinmeters != null)
                Text(
                  "Discrepancy: $_distanceinmeters meters",
                  textAlign: TextAlign.center,
                ),
              if (state == AppState.unsuccessful)
                Text(
                  "The Distance between the address extracted from OCR and the address otained from GPS is more than 300 metres. Reset and scan again",
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
    );
  }
}

//TODO: Improve UI
//Show OCR Result with scanned address and cropped document image
//Verify extracted location with GPS location in a limit of 300m
//Show Error on wrong location verification
//User will be given a countdown of 1 min to press confirm or reset
//If user confirms store scanned image in storage and update the ongoing document step, timestamp, pincode and scanned_address field
