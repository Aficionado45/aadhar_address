import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
var uuid=Uuid();
Future<Map<String, dynamic>> getcaptcha() async {
  final Map<String, dynamic> params = {
    "langCode": "en",
    "captchaLength": "3",
    "captchaType": "2"
  };
  var myUri = Uri.parse(
      "https://stage1.uidai.gov.in/unifiedAppAuthService/api/v2/get/captcha");

  var response = await http.post(myUri, body: json.encode(params), headers: {
    'Content-type': 'application/json',
  });
  print('Called');
  Map<String, dynamic> responsebody = json.decode(response.body);
  return responsebody;
}

Future<Map<String,dynamic>> getotp(aadharno,captcha,captchatxnid) async {
  final uuidno = uuid.v4();
  final Map<String, dynamic> params = {
    //as uid give the uid
    "uidNumber": "999985981663",
    "captchaTxnId": captchatxnid,
    "captchaValue": captcha,
    "transactionId": "MYAADHAAR:${uuidno}"
  };
  var myUri = Uri.parse(
      "https://stage1.uidai.gov.in/unifiedAppAuthService/api/v2/generate/aadhaar/otp");
  var response = await http
      .post(myUri, body: json.encode(params), headers: {
    'x-request-id': '${uuidno}',
    'appid': 'MYAADHAAR',
    'Accept-Language':'en_in',
    'Content-Type': 'application/json'
  });
  Map<String, dynamic> responsebody = json.decode(response.body);
  return responsebody;
}

Future<bool> validateOTP(String aadharno, String otp, String txnid) async{
  final Map<String, dynamic> params = {
    'txnNumber': txnid,
    'otp': otp,
    'shareCode': '0000',
    'uid': aadharno
  };
  var myUri = Uri.parse('https://stage1.uidai.gov.in/eAadhaarService/api/downloadOfflineEkyc');
  var response = await http.post(myUri, body: json.encode(params), headers: {
    'Content-Type': 'application/json'
  });
  Map<String, dynamic> responsebody = json.decode(response.body);
  if(responsebody['status'] == 'Success'){
    return true;
  }
  else{
    return false;
  }
}