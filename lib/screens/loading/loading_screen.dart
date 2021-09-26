import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

Future myFuture;

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    myFuture = taskInTheFuture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator(); //TOdo loading page
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}'); //TOdo error page
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
    await smsProvider.updateSmsList();
    smsProvider.clearTheListFromCurrent();
    smsProvider.setSendingInProgress(false);
    await smsProvider.updateSmsList();
  }
}
