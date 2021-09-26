import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/screens/components/sms_bubble.dart';
import 'package:depo_sms/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';

class ReadedFileScreen extends StatefulWidget {
  @override
  _ReadedFileScreenState createState() => _ReadedFileScreenState();
}

class _ReadedFileScreenState extends State<ReadedFileScreen> {
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
          title: Text(
            "Beolvasott fájl",
            style: TextStyle(color: purple),
          ),
          leading: BackButton(
            color: purple,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
        ),
        body: Consumer<SmsModel>(
          builder: (_, provider, __) => ListView(
            children: provider.currentSmsList
                .map(
                  (sms) => SmsBubble(sms: sms),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
