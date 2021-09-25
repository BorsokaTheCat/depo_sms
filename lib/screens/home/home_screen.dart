
import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/screens/components/rounded_button.dart';
import 'package:depo_sms/screens/home/components/home_appbar.dart';
import 'package:depo_sms/services/file_reading_service.dart';
import 'package:depo_sms/services/permission_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import 'components/chosed_file_field.dart';
import 'components/header.dart';
import 'components/secound_textfiled.dart';
import 'package:provider/provider.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'dart:async';
import 'dart:io';


class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

String _path="";
bool _isButtonDisabled=false;

class _FavouritesScreenState extends State<HomeScreen> {

  bool _pickFileInProgress = false;


  final _utiController = TextEditingController(
    text: 'com.sidlatau.example.mwfbak',
  );

  final _extensionController = TextEditingController(
    text: 'mwfbak',
  );

  final _mimeTypeController = TextEditingController(
    text: 'application/pdf image/png',
  );

  String _status = ' ';
  bool _iosPublicDataUTI = true;
  bool _checkByCustomExtension = false;
  bool _checkByMimeType = false;
  bool _isButtonDisabled = false;
  bool _isInTheRightFormat = false;

  _pickDocument() async {
    String result;
    //currentSmsCounter = 0;
    //currentSmsList.clear();

    try {
      setState(() {
        _path = '-';
        _pickFileInProgress = true;
      });

      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
        allowedFileExtensions: _checkByCustomExtension
            ? _extensionController.text
            .split(' ')
            .where((x) => x.isNotEmpty)
            .toList()
            : null,
        allowedUtiTypes: _iosPublicDataUTI
            ? null
            : _utiController.text
            .split(' ')
            .where((x) => x.isNotEmpty)
            .toList(),
        allowedMimeTypes: _checkByMimeType
            ? _mimeTypeController.text
            .split(' ')
            .where((x) => x.isNotEmpty)
            .toList()
            : null,
      );

      result = await FlutterDocumentPicker.openDocument(params: params);
    } catch (e) {
      print(e);
      result = 'Error: $e';
    } finally {
      setState(() {
        _pickFileInProgress = false;
      });
    }

    setState(() {
      _path = result;
    });

    final file = new File(_path);
    Stream<List<int>> inputStream = file.openRead();
    FileReadingService fileService = new FileReadingService();
    fileService.read(_path, context);

  }

  Future<void> askStoragePermission() async {
    if(_pickFileInProgress){
      print('pick file in progress');
    }else{
      await PermissionsService().requestStoragePermission()
          ?_pickDocument
          : print('Permission has been denied');
    }
  }


  final secoundsController = TextEditingController(/*text: "5"*/);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: HomeAppbar(
        openPressed: askStoragePermission,//todo
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
