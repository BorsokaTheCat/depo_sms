

import 'dart:convert';
import 'dart:io';

import 'package:depo_sms/model/bean/sms.dart';
import 'package:depo_sms/model/sms_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FileReadingService{

  Future<void> read(String path, BuildContext context ) async {
    var smsProvider = context.read<SmsModel>();


    final file = new File(path);
    Stream<List<int>> inputStream = file.openRead();

    inputStream
        .transform(utf8.decoder) // Decode bytes to UTF-8.
        .transform(new LineSplitter()) // Convert stream to individual lines.
        .listen((String line) async {
      List arr =[];


      if(_isItARightNumber(line)){
        arr = line.split(";");
        Sms currentSms = new Sms( number:arr[0], message:arr[1], feedback: "Nem elküldött sms.", time: null, current: 1);
        await smsProvider.insertSms(currentSms);

      }else{
        print("nem jo a telefonszám formátum");
        //_isInTheRightFormat=false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("A fájl formátuma nem megfelelő."),
        ));
      }
    }, onDone: () {
      print('File is now closed.');
    }, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Hiba a fájl beolvasása közben: "+e.toString()),
      ));
      print(e.toString());
    });
  }

  bool _isItARightNumber(String line){
    RegExp regExp = new RegExp(
      r"\+?[0-9]{11,12};.*\n?",
      caseSensitive: false,
      multiLine: true,
    );
    print(regExp.allMatches(line).toString());
    return regExp.hasMatch(line);
  }

}
