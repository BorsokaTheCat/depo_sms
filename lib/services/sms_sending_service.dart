import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:depo_sms/model/sms_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';

class SmsSendingService{

  void startSendingWithDelay(BuildContext context) {
    var smsProvider = context.read<SmsModel>();
    print('3 startSendingWithDelay smscouner: '+smsProvider.currentSmsCounter.toString());

    smsProvider.currentSmsCounter = smsProvider.currentSmsList.length;
    print("currentSmsCounter: "+smsProvider.currentSmsCounter.toString());

    Timer.periodic(Duration(seconds: smsProvider.sendingDelay), (Timer timer) async {
      print("belül: "+smsProvider.currentSmsCounter.toString());
      if (smsProvider.currentSmsCounter==0) {
        print("stop: ");
        timer.cancel();
        smsProvider.setSendingInProgress(false);
      }else{
        print("send sms: ");
        smsProvider.currentSmsCounter--;
        await _smsSend(smsProvider.currentSmsCounter,context);//?
      }
    });

  }

  Future<void> _smsSendImitation(int i,BuildContext context) async {
    var smsProvider = context.read<SmsModel>();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd  kk:mm').format(now);

    smsProvider.currentSmsList[i].time=formattedDate;

    print('4sms kiküldése ELŐTT '+smsProvider.currentSmsList[i].toString());
    //rint("number: "+number);
    //print("currentSmsList: "+smsProvider.currentSmsList[i].message);
        smsProvider.currentSmsList[i].feedback  = "SMS elküldve!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);


    print('4sms kiküldése után '+smsProvider.currentSmsList[i].toString());
  }



  Future<void> _smsSend(int i,BuildContext context) async {
    var smsProvider = context.read<SmsModel>();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd  kk:mm').format(now);

    smsProvider.currentSmsList[i].time=formattedDate;



    final SmsSendStatusListener listener = (SendStatus status) async {
      // Handle the status
      print(status.toString()+" status");
      if(status== SendStatus.SENT){

        smsProvider.currentSmsList[i].feedback  = "SMS elküldve!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      }else if (status == SendStatus.DELIVERED) {

        smsProvider.currentSmsList[i].feedback  = "SMS kézbesítve!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      }
    };
    final Telephony telephony = Telephony.instance;

    String number = smsProvider.currentSmsList[i].number;
    String message = smsProvider.currentSmsList[i].message;
    telephony.sendSms(
      to: number,
      message: message,
      statusListener: listener,
      isMultipart: true,
    );


  }

}