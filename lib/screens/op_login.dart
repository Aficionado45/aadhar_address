import 'package:aadhar_address/screens/op_otp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aadhar_address/screens/op_otp.dart';
import 'package:xml/xml.dart';

class opLogin extends StatefulWidget {
  const opLogin();

  @override
  _opLoginState createState() => _opLoginState();
}

String op_aadhar;

class _opLoginState extends State<opLogin> {
  @override

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('operator');
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  bool error = false;

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
        ),
        backgroundColor: Colors.white,
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 13.6,
                child: TextField(
                  // maxLength: 12,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 20,
                  ),
                  onChanged: (value) {
                    if (value.isEmpty)
                      return null;
                    else {
                      op_aadhar = value;
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(
                        // color: Colors.redAccent,
                          width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(
                        // color: Colors.redAccent,
                          width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    labelText: "Operator Aadhaar Number",
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
                  onPressed: () async {
                    bool exists = await checkIfDocExists(op_aadhar);
                    if (op_aadhar != null && op_aadhar.length == 12 && exists) {
                      setState(() {
                        error = false;
                      });
                      Navigator.pushNamed(context, 'opotp');
                    }
                    else{
                      setState(() {
                        error = true;
                      });
                    }
                    Uri myUri = Uri.parse(
                        "https://otp-stage.uidai.gov.in/uidotpserver/2.5/public/9/9/MEY2cG1nhC02dzj6hnqyKN2A1u6U0LcLAYaPBaLI-3qE-FtthtweGuk");
                    var data = '''<?xml version="1.0" encoding="UTF-8"?>
<ns2:Otp xmlns:ns2="http://www.uidai.gov.in/authentication/otp/1.0" ac="public" lk="MAElpSz56NccNf11_wSM_RrXwa7n8_CaoWRrjYYWouA1r8IoJjuaGYg" sa="public" ts="2021-10-27T19:20:03" txn="uuid" type="A" uid="999919971593" ver="2.5">
    <Opts ch="01"/>
    <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
        <SignedInfo>
            <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
            <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
            <Reference URI="">
                <Transforms>
                    <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
                </Transforms>
                <DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
                <DigestValue>/BW8qlNQwImL/C+rzzUP7D9kE6E=</DigestValue>
            </Reference>
        </SignedInfo>
        <SignatureValue>WonaS0Xag17YBPwXt/FYG/+VB+GXUK7NTBEzc1weGl38E7NRkEwTXfOs1JhR5c562e57/z4lm2aN+DAez5XrE+V1MigWtzuW5yPEOVPWZMW5DtocCz8JXkFqmsDz9wEGW6E8knGA/BzAEa9ipfHunYnG78YvTze/ffO/EVAOfS8HXhSY1s6V4HrsZuLrI/3HtMsjjurynnkFOpBcERfSpshuiU3WLsUasDi2L4UDE3oyaoUxlcO89Oih59cmRoC0xa/7NDOGnaRNcZhkeBpmOiEBW6vKUrhNMnp8gahetv7mqZ933Mf4Dza2kkMke2k5124DiR5SkGlGfKrQjc5K8Q==</SignatureValue>
        <KeyInfo>
            <X509Data>
                <X509SubjectName>CN=Public AUA for Staging Services,OU=Staging Services,O=Public AUA,L=Bangalore,ST=KA,C=IN</X509SubjectName>
                <X509Certificate>MIIDuTCCAqGgAwIBAgIHBbjQqpe5NjANBgkqhkiG9w0BAQUFADCBjTELMAkGA1UEBhMCSU4xCzAJBgNVBAgTAktBMRIwEAYDVQQHEwlCYW5nYWxvcmUxEzARBgNVBAoTClB1YmxpYyBBVUExGTAXBgNVBAsTEFN0YWdpbmcgU2VydmljZXMxLTArBgNVBAMTJFJvb3QgUHVibGljIEFVQSBmb3IgU3RhZ2luZyBTZXJ2aWNlczAeFw0yMDA1MjUwOTMyMjRaFw0yNDA1MjUwOTMyMjRaMIGIMQswCQYDVQQGEwJJTjELMAkGA1UECBMCS0ExEjAQBgNVBAcTCUJhbmdhbG9yZTETMBEGA1UEChMKUHVibGljIEFVQTEZMBcGA1UECxMQU3RhZ2luZyBTZXJ2aWNlczEoMCYGA1UEAxMfUHVibGljIEFVQSBmb3IgU3RhZ2luZyBTZXJ2aWNlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAI+b6Gcwg0+MJP+YUePflCCEBWj3PdICPenFMqETxTACphlhPKjO2XAnWU3frp+a76NBqEbZ5ZOrUeE70Dj9BHZo7gFm72BNuU5AFYwvCGzCVButExgVAe9bWO07bG1TKwdPEPUzO2O8QV7YaaHFU+SfZTPRam3ycn6nfIceue9n1IH6sAdCgcfiKpgBYbenrG+u9bNVrvasYCXPUBqS1CzsVGv75ekdCu7vxbr3w941KO31kdCQpVVas+khAC3vMKWkhR77PHoGQvx5yvsGW9QPVw+JLHabGlRNe3C4xMZ1rdCUslQ7VshQlkDQIxiu9jOk+B1wexT78wtVGvunolkCAwEAAaMhMB8wHQYDVR0OBBYEFB6nQeWTHs78YZvfDfnSWIuXuU2cMA0GCSqGSIb3DQEBBQUAA4IBAQAp+MnpqVO1SJ+ilCS++L7WV4AQlVTwCzHW4QyIV+6Mb50PIYhmoFXjKF7t71jvQ3WP2jocp7Ouy07+sT7Knuhy4/RpCwCSyZpKCQjfRqKPEW8CYc17TEYUxufvwBfzzOGZCTIwtgGrOC23XoVXNd+bwn1Lbsrb0dd98Rp3AGccwcVPp8TgwzNY2oH78HRF/ScUONebyCT+eOICVxjc73qnYvGe5t25bl/kgm6NsAYimr/at7suqiMZQWp5SEfbRYCZ9wvQsJgX01g92zk3ELV9g5fbO9VrKr9vN0QA7VjkrfzuCtR/MGIsYBpZzcX1vDlUscXO1u4fVROETTOSS3jc</X509Certificate>
            </X509Data>
        </KeyInfo>
    </Signature>
</ns2:Otp>''';
                    var response =
                        await http.post(myUri, body: data, headers: {
                      'Content-type': 'text/xml',
                    });
                    print(response.body);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Please enter a valid 12 digit Aadhaar Number',
                style: TextStyle(
                  color: error ? Colors.red : Colors.white,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 12,)
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: Improve UI
//add error for wrong inputs(Less than 12 digits / wrong operator aadhar no.)
//Auth API integeation
