import 'package:flutter/material.dart';

class scanDoc extends StatefulWidget {
  const scanDoc();

  @override
  _scanDocState createState() => _scanDocState();
}

class _scanDocState extends State<scanDoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Scan Documents",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Icon(Icons.camera),
          ],
        ),
      ),
    );
  }
}
