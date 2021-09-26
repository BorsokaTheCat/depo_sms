import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:depo_sms/model/sms_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sms/sms.dart';

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


/*
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
  }*/



  Future<void> _smsSend(int i,BuildContext context) async {
    var smsProvider = context.read<SmsModel>();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd  kk:mm').format(now);

    smsProvider.currentSmsList[i].time = formattedDate;


    SmsSender sender = new SmsSender();
    String number = smsProvider.currentSmsList[i].number;
    SmsMessage message = new SmsMessage(
        number, smsProvider.currentSmsList[i].message);
    print('4sms kiküldése ELŐTT ' + smsProvider.currentSmsList[i].toString());
    print("number: " + number);
    print("currentSmsList: " + smsProvider.currentSmsList[i].message);
    message.onStateChanged.listen((state) async {
      if (state == SmsMessageState.Sent) {
        smsProvider.currentSmsList[i].feedback = "SMS elküldve!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else if (state == SmsMessageState.Delivered) {
        smsProvider.currentSmsList[i].feedback = "SMS kézbesítve!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else if (state == SmsMessageState.Sending) {
        smsProvider.currentSmsList[i].feedback = "SMS küldés alatt!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else if (state == SmsMessageState.Fail) {
        smsProvider.currentSmsList[i].feedback = "SMS küldése sikertelen!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else if (state == SmsMessageState.None) {
        smsProvider.currentSmsList[i].feedback = "SMS elveszett!";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      } else {
        smsProvider.currentSmsList[i].feedback = "Várjuk az eredményt.";
        await smsProvider.updateSms(smsProvider.currentSmsList[i]);
      }
    });
    sender.sendSms(message);
  }

  }
