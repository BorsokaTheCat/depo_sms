import 'package:depo_sms/model/bean/sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class SmsBubble extends StatelessWidget {
  //ask for a vehicle
  final Sms sms;

  const SmsBubble({
    Key key,
    this.sms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        color: sms.feedback=="Nem elküldött sms."?darkPurple:lightPurple,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: size.height*0.005,),
              _smsDetailRow("Telefonszám:  ", sms.number.toString()),
              _smsDetailRow("Üzenet:             ", sms.message.toString()),
              _smsDetailRow("Státusz:            ", sms.feedback.toString()),
              _smsDetailRow("Időpont:            ", sms.time.toString()),
              SizedBox(height: size.height*0.005,),
            ],
          ),
        )
      ),
    );
  }

  Widget _smsDetailRow(String title, String detail){
    return Row(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
        Expanded(child: Text(detail)),
      ],
    );
  }



}
