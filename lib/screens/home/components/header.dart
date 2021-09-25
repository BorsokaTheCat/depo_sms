import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../colors.dart';

//the default blue appbar with one back button
class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.04),
        Center(
          child: Image.asset(
            "images/depo.png",
            height: size.height * 0.45,
          ),
        ),
        SizedBox(height: size.height * 0.03),
      ],
    );
  }
}
