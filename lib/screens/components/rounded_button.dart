import 'package:depo_sms/colors.dart';
import 'package:flutter/material.dart';

//the default big rounded button
class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = purple,
    this.textColor = white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      height: size.height * 0.08,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        // ignore: deprecated_member_use
        child: FlatButton(
          //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: textTheme.headline6.copyWith(color: white)
          ),
        ),
      ),
    );
  }
}
