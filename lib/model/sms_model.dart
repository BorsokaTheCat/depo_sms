import 'package:depo_sms/services/localDbService/model_helpers/sms_helper.dart';
import 'package:flutter/foundation.dart';

import 'bean/sms.dart';

class SmsModel with ChangeNotifier {
  List<Sms> smsList = [];

  SmsHelper _smsHelper = new SmsHelper();

  Future<int> updateBluegoServicesList() async {
    smsList.clear();
    smsList= await _smsHelper.makeSmsList();
    notifyListeners();
    return smsList.length;
  }

  Future<void> insertBlugoService(Sms sms) async {
    _smsHelper.insertSms(sms);
    await updateBluegoServicesList(); // if we insert somebody(somebody register) he will be our current user;
    notifyListeners();
  }

  void deleteBlugoService(Sms sms) {
    _smsHelper.deleteSms(sms);
    notifyListeners();
  }

  Future<void> updateBlugoService(Sms sms) async {
    _smsHelper.updateSms(sms);
    //updateVehiclesList();
  }

  void printBlugoServices() {
    print("print BlugoServices from db:");
    _smsHelper.querySms();
  }
}
