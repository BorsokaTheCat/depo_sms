import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:sms/sms.dart';

import 'package:intl/intl.dart';
import 'package:depo_sms/model/sms_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SmsSendingService{

  void startSendingWithDelay(BuildContext context) {
    var smsProvider = context.read<SmsModel>();
    int currentSmsCounter=0;

    Timer(Duration(seconds: smsProvider.sendingDelay), () {
      if (currentSmsCounter < smsProvider.currentSmsList.length) {
        _smsSend(currentSmsCounter,context);//?
        currentSmsCounter += 1;
        startSendingWithDelay(context);
      }
    });

    smsProvider.sendingInProgress=true;
    if (currentSmsCounter == smsProvider.currentSmsList.length) {
      int lngth=smsProvider.currentSmsList.length;
      print('elvileg $currentSmsCounter == $lngth akkor sendinginprocess false és currentek =0');
      smsProvider.sendingInProgress=false;
      smsProvider.currentSmsList.forEach((element) {
        element.current=0;
        smsProvider.updateSms(element);
      });
    }
  }


  Future<void> _smsSend(int i,BuildContext context) async {
    var smsProvider = context.read<SmsModel>();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    smsProvider.currentSmsList[i].time=formattedDate;


    SmsSender sender = new SmsSender();
    String number = smsProvider.currentSmsList[i].number;
    SmsMessage message = new SmsMessage(number, smsProvider.currentSmsList[i].message);
    message.onStateChanged.listen((state) async {
      if (state == SmsMessageState.Sent) {
        smsProvider.currentSmsList[i].feedback  = "SMS elküldve!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else if (state == SmsMessageState.Delivered) {

        smsProvider.currentSmsList[i].feedback  = "SMS kézbesítve!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else if (state == SmsMessageState.Sending) {

        smsProvider.currentSmsList[i].feedback  = "SMS küldés alatt!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else if (state == SmsMessageState.Fail) {

        smsProvider.currentSmsList[i].feedback  = "SMS küldése sikertelen!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else if (state == SmsMessageState.None) {

        smsProvider.currentSmsList[i].feedback  = "SMS elveszett!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else {

        smsProvider.currentSmsList[i].feedback  = "Várjuk az eredményt.";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      }
    });

    sender.sendSms(message);
    /*for(int i=0;i<currentSmsList.length;i++){
      _update(currentSmsList[i].id, currentSmsList[i].feedback);
    }*/
  }

}