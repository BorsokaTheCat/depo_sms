import 'package:depo_sms/services/localDbService/model_helpers/sms_helper.dart';
import 'package:flutter/foundation.dart';

import 'bean/sms.dart';

class SmsModel with ChangeNotifier {
  List<Sms> smsList = [];
  List<Sms> currentSmsList = [];

  bool sendingInProgress = false;
  int sendingDelay = 0;
  int currentSmsCounter = 0;

  SmsHelper _smsHelper = new SmsHelper();

  void setSendingInProgress(bool bool) {
    sendingInProgress = bool;
    print('sendingInProgress changed to: $bool');
    notifyListeners();
  }

  Future<int> updateSmsList() async {
    smsList.clear();
    currentSmsList.clear();
    smsList = await _smsHelper.makeSmsList();
    currentSmsList = await _smsHelper.makeCurrentSmsList();
    notifyListeners();
    return smsList.length;
  }

  Future<void> insertSms(Sms sms) async {
    _smsHelper.insertSms(sms);
    await updateSmsList();
  }

  Future<void> deleteSms(Sms sms) async {
    _smsHelper.deleteSms(sms);
    await updateSmsList();
  }

  Future<void> updateSms(Sms sms) async {
    _smsHelper.updateSms(sms);
    await updateSmsList();
  }

  void deleteSmsDb() {
    _smsHelper.deleteSmsTable();
    smsList.clear();
    currentSmsList.clear();
    notifyListeners();
  }

  void printSms() {
    print("print BlugoServices from db:");
    _smsHelper.querySms();
  }

  void printCurrentSms() {
    print("print BlugoServices from db:");
    _smsHelper.queryCurrentSms();
  }

  Future<void> clearTheListFromCurrent() async {
    for (int i = 0; i < smsList.length; i++) {
      smsList[i].current = 0;
      await updateSms(smsList[i]);
    }
  }
}
