import 'package:depo_sms/screens/components/rounded_button.dart';
import 'package:depo_sms/screens/home/components/home_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import 'components/chosed_file_field.dart';
import 'components/header.dart';
import 'components/secound_textfiled.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<HomeScreen> {

  final secoundsController = TextEditingController(/*text: "5"*/);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: HomeAppbar(
        openPressed: null, //todo
        savePressed: null, //todo
      ),
      // This is handled by the search bar itself.
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Header(),
              ChosedFileField(
                title: '$_path',
              ),
              SecondsField(
                controller: secoundsController,
              ),
              SizedBox(
                height: 50.0,
              ),
              RoundedButton(
                text: "db",
                color: _isButtonDisabled ? grey : purple,
                press: null, //todo
              ),
              /*Align(
                alignment: Alignment.center,
                child: FlatButton(
                  color: _isButtonDisabled ? Colors.grey : Color(0xff3f1272),
                  onPressed: () {
                    //smsList.clear();
                    for (int i = 0; i < currentSmsList.length; i++) {
                      print(currentSmsList[i].toString());
                    }
                  },
                  child: const Text('current!',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  //elevation: 5,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  color: _isButtonDisabled ? Colors.grey : Color(0xff3f1272),
                  onPressed: () {
                    _canWeSendSmses();
                  },
                  child: const Text('Küldés!',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  //elevation: 5,
                ),
              ),
              Center(child: Text('$_status')),*/
            ],
          ),
        ),
      ),
    );
  }
}
