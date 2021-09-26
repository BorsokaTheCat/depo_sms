import 'package:depo_sms/colors.dart';
import 'package:depo_sms/screens/readed_file/readed_file_screen.dart';
import 'package:flutter/material.dart';

class ChosedFileField extends StatelessWidget {
  final String title;

  const ChosedFileField({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReadedFileScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        //line and text
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        // just text
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: purple,
                width: 2.0,
              ),
            )),
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(title),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
