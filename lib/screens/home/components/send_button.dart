import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/screens/components/rounded_button.dart';
import 'package:depo_sms/services/permission_service.dart';
import 'package:depo_sms/services/sms_sending_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';

class SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var smsProvider = context.read<SmsModel>();
    print(smsProvider.sendingInProgress.toString() + "ssssssssssssss");
    return Consumer<SmsModel>(
      builder: (_, provider, __) => Align(
        alignment: Alignment.center,
        child: RoundedButton(
          text: "KÜLDÉS",
          color: provider.sendingInProgress ? Colors.grey : Color(0xff3f1272),
          press: () {
            _canWeSendSmses(context);
          },
          //elevation: 5,
        ),
      ),
    );

  }
}

SmsSendingService smsSendingService = new SmsSendingService();
PermissionsService permissionsService = new PermissionsService();

Future<void> _canWeSendSmses(BuildContext context) async {
// Check if a device is capable of sending SMS
  final Telephony telephony = Telephony.instance;
  bool canSendSms = await telephony.isSmsCapable;
  print('canSendSms: $canSendSms');

// Get sim state
  SimState simState = await telephony.simState;
  print('simState: $simState');

  bool permissionsGranted = await telephony.requestPhoneAndSmsPermissions;

  var smsProvider = context.read<SmsModel>();
  if (smsProvider.sendingInProgress == true) {
    print("már folyamatban van a küldés");

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      "Már folyamatban van a küldés",
    )));
  } else if (smsProvider.sendingDelay == 0) {
    print("nincs megadva másodperc");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      "Kérlek adj meg eltolási időt az smsekhez!",
    )));
  } else if (smsProvider.currentSmsList.length == 0) {
    print("nincs beolvasva fájl");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      "Kérlek olvass be fájlt!",
    )));
  } else if (canSendSms == false) {
    print("Ezzel a telefonnal nem tudunk sms-t küldeni.");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      "Ezzel a telefonnal nem tudunk sms-t küldeni.",
    )));
  } else if (simState != SimState.READY) {
    print("Nincs engedély.");
    permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      "Nincs engedély",
    )));
  } else if (permissionsGranted == false) {
    print("Valami probléma akadt a sim kártyával.");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      "Valami probléma akadt a sim kártyával.",
    )));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      "Elkezdődött a kiküldés!",
    )));
    smsProvider.setSendingInProgress(true);
    smsSendingService.startSendingWithDelay(context);
  }

}
