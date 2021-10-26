import 'package:aadhar_address/screens/user_login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> submitFeedback(String feedback) async{
  DateTime timestamp = DateTime.now();
  await FirebaseFirestore.instance.collection('feedbacks')
        .doc('$user_aadhar'+'_'+'${timestamp.toString()}')
        .set({
          'reference_id': user_aadhar,
          'timestamp': timestamp.toString(),
          'feedback': feedback,
        });
}

Future<void> getFeedback(BuildContext context){

  String feedback = '';

  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        'Raise a Suggestion',
      ),
      content: TextField(
        decoration: InputDecoration(
          hintText: 'Enter your feedback/suggestion/query',
        ),
        onChanged: (val){
          feedback = val;
        },
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            'Submit',
          ),
          onPressed: () async{
            if(feedback != ''){
              await submitFeedback(feedback);
            }
            Navigator.pop(context);
          },
        )
      ],
    ),
  );
}