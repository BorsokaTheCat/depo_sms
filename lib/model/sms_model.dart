import 'package:depo_sms/services/localDbService/model_helpers/sms_helper.dart';
import 'package:flutter/foundation.dart';

import 'bean/sms.dart';

class SmsModel with ChangeNotifier {
  List<Sms> smsList = [];
  List<Sms> currentSmsList = [];

  bool sendingInProgress=false;
  int sendingDelay=0;

  SmsHelper _smsHelper = new SmsHelper();

  Future<int> updateSmsList() async {
    smsList.clear();
    currentSmsList.clear();
    smsList= await _smsHelper.makeSmsList();
    currentSmsList= await _smsHelper.makeCurrentSmsList();
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

  void printSms() {
    print("print BlugoServices from db:");
    _smsHelper.querySms();
  }
}
