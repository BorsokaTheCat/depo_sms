import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/services/sms_sending_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';

class SendButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var smsProvider = context.read<SmsModel>();
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          style: TextButton.styleFrom(
            primary:  smsProvider.sendingInProgress ? Colors.grey : Color(0xff3f1272),
          ),
           onPressed: () {
            _canWeSendSmses(context);
          },
          child: const Text('Küldés!',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          //elevation: 5,
        ),
      ),
    );
  }
}

SmsSendingService smsSendingService = new SmsSendingService();
void _canWeSendSmses(BuildContext context) {
  var smsProvider = context.read<SmsModel>();
  if (smsProvider.sendingInProgress  == true) {

  } else if (smsProvider.sendingDelay != 0 && smsProvider.currentSmsList.length !=0 ) {
    smsSendingService.startSendingWithDelay(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Kérlek helyesen töltsd ki az adatokat.",)));
  }
}
