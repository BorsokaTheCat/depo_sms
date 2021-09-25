import 'package:depo_sms/model/bean/sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmsBubble extends StatelessWidget {
  //ask for a vehicle
  final Sms sms;

  const SmsBubble({
    Key key,
    this.sms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //when we came from a form we need to go there back
    //when we not we just want to edit the vehicle
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey,
        child: Column(
          children: [
            Divider(),
            Text(sms.id.toString()),
            Text(sms.number.toString()),
            Text(sms.message.toString()),
            Text(sms.feedback.toString()),
            Text(sms.time.toString()),
            Text(sms.current.toString()),
            Divider(),
          ],
        )
      ),
    );
  }

}
