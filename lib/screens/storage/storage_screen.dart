
import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/screens/components/delete_button.dart';
import 'package:depo_sms/screens/components/refresh_button.dart';
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
            RefreshButton(
              iconColor: Color(0xff3f1272),
              onPressed: () async {
                //await fillResultListFromDB();
                setState(() {

                });
              },
            ),
          ],
        ),//todo list from provider
        body:Consumer<SmsModel>(
          builder: (_, provider, __) => ListView(
            children: provider.smsList
                .map(
                  (sms) => SmsBubble(sms: sms), //todo smsbuble
            )
                .toList(),
          ),
        ),
      ),
    );


  }

  void _showDialog() {
    // flutter defined function
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
                //await _deleteDB();
                setState(() {
                });
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

/*
  Future<void> _deleteDB() async {
    await globals.dbHelper.deleteDB();
    smsResults.clear();
  }

  Future<void> fillResultListFromDB() async{
    smsResults.clear();
    final allRows = await globals.dbHelper.queryAllRows();
    for(int i=0;i<allRows.length;i++){
      smsResults.add(
          allRows[i]['number'] + "-részére: " + allRows[i]['feedback'] +"\n\n" + allRows[i]['time'] + " \n\n");
    }
  }


*/
}

