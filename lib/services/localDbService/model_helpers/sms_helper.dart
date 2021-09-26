
import 'package:depo_sms/model/bean/sms.dart';

import '../db_query_helper.dart';
import '../local_db_service.dart';

class SmsHelper {
  final dbHelper = DatabaseHelper.instance;
  final queryHelper = QueryHelper.instance;

  ///insert the received supplier to the local db
  Future<void> insertSms(Sms sms) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: sms.id,
      DatabaseHelper.columnNumber: sms.number,
      DatabaseHelper.columnMessage: sms.message,
      DatabaseHelper.columnFeedback: sms.feedback,
      DatabaseHelper.columnTime: sms.time,
      DatabaseHelper.columnCurrent: sms.current,
    };
    await dbHelper.insert(row);
  }

  void updateSms(Sms sms) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: sms.id,
      DatabaseHelper.columnNumber: sms.number,
      DatabaseHelper.columnMessage: sms.message,
      DatabaseHelper.columnFeedback: sms.feedback,
      DatabaseHelper.columnTime: sms.time,
      DatabaseHelper.columnCurrent: sms.current,
    };
    await dbHelper.update(row,);
  }

  void deleteSms(Sms sms) async {
    int id = sms.id;
    print(id);
    await dbHelper.delete(
        id);
  }

  void querySms() async {
    var allSuppliers =
    await dbHelper.queryAllRows();
    allSuppliers.forEach(print);
  }
  void queryCurrentSms() async {
    var allSuppliers =
    await dbHelper.queryRows();
    allSuppliers.forEach(print);
  }

  Future<List<Sms>> makeSmsList() async {
    var allSuppliers =
    await dbHelper.queryAllRows();
    return makeListFromMap(allSuppliers);
  }

  List<Sms> makeListFromMap(List<Map<String, dynamic>> map) {
    List<Sms> supplierList = [];

    for (int i = 0; i < map.length; i++) {
      supplierList.add(new Sms(
        id: map[i]['id'],
        number: map[i]['number'],
        message: map[i]['message'],
        feedback: map[i]['feedback'],
        time: map[i]['time'],
          current: map[i]['current']
      ));
    }
    return supplierList;
  }

  Future<List<Sms>> makeCurrentSmsList() async {
    var allFavourite = await dbHelper
        .queryRows(/*queryHelper.createCurrentSmsesQueryString()*/);

    return makeListFromMap(allFavourite);
  }
}
