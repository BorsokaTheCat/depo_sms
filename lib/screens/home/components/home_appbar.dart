import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../colors.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final Function savePressed;
  final Function openPressed;

  HomeAppbar(
      {Key key,
        this.title,
        this.savePressed,
        this.openPressed})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            child: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.save,
                  color: purple,
                ),
                onPressed: savePressed,
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: purple,
                  ),
                  onPressed: openPressed,
                )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
        ),
      ),
      body: SizedBox(),
    );
  }
}


