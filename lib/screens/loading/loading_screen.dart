
import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'loading_screen.dart';

//some rules
// https://support.google.com/googleplay/android-developer/answer/10808976?hl=hu

//this page is help to initialize provided data's when the app started
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

int i = 0;
bool loggedIn = false;
Future myFuture;



class _LoadingScreenState extends State<LoadingScreen> {
  //we need this initState to prevent the taskInTheFuture to be called multiple times
  //https://stackoverflow.com/questions/61802115/why-is-futurebuilder-called-multiple-times
  @override
  void initState() {
    myFuture = taskInTheFuture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              //if we have a profile in the local db we can go to the mapScreen else go to login
              return HomeScreen();
        }
      },
    );
  }

  //before we build the main screen we need initialize some data
  Future<void> taskInTheFuture() async {
    var smsProvider = context.read<SmsModel>();
    print("taskInTheFuture");
    await smsProvider.updateSmsList();
    smsProvider.clearTheListFromCurrent();
    smsProvider.setSendingInProgress(false);
    await smsProvider.updateSmsList();
  }

}
