

import 'local_db_service.dart';

class QueryHelper {
  final dbHelper = DatabaseHelper.instance;

  // make this a singleton class
  QueryHelper._privateConstructor();

  static final QueryHelper instance = QueryHelper._privateConstructor();


  ///create a select string to select the current profile's favourites
  List<dynamic> createCurrentSmsesQueryString() {
    var queryList = [];

    String queryString = "select * from sms where id>2";
    var queryDetails = [];

    queryList.addAll([queryString, queryDetails]);
    return queryList;
  }

}
