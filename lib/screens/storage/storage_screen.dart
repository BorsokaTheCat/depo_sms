
import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/screens/components/delete_button.dart';
import 'package:depo_sms/screens/components/sms_bubble.dart';
import 'package:depo_sms/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';


class StorageScreen extends StatefulWidget {
  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: colorCustom,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: "stat",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Eredmények", style: TextStyle(color: Color(0xff3f1272)),),
          leading:
          BackButton(
            color: Color(0xff3f1272),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          actions: [
            DeleteButton(
              iconColor: Color(0xff3f1272),
              onPressed: () async{
                //_deleteDB();
                _showDialog();

              },
            ),
          ],
        ),
        body:Consumer<SmsModel>(
          builder: (_, provider, __) => ListView(
            children: provider.smsList
                .map(
                  (sms) => SmsBubble(sms: sms),
            )
                .toList(),
          ),
        ),
      ),
    );


  }

  void _showDialog() {
    // flutter defined function
    var smsProvider = context.read<SmsModel>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Biztosan töröljük az adatbázist?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Töröl"),
              onPressed: () async {
                 smsProvider.deleteSmsDb();
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: new Text("Mégsem"),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}

