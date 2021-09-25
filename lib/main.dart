import 'package:depo_sms/model/sms_model.dart';
import 'package:depo_sms/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SmsModel>(create: (_) => SmsModel()),
        //ChangeNotifierProvider<VehiclesModel>(create: (_) => VehiclesModel()),
        //Provider<AnotherThing>(create: (_) => AnotherThing()),
      ],
      child:MaterialApp(/*
        theme: ThemeData(
//roboto
          fontFamily: 'OpenSans',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 28.0,color: darkGrey, fontWeight: FontWeight.w600),
            headline2: TextStyle(fontSize: 24.0,color: darkGrey, fontWeight: FontWeight.w700),
            headline3: TextStyle(fontSize: 22.0,color: darkGrey, fontWeight: FontWeight.w700),
            headline4: TextStyle(fontSize: 20.0,color: darkGrey, fontWeight: FontWeight.w600),
            headline5: TextStyle(fontSize: 18.0,color: darkGrey, fontWeight: FontWeight.w600),
            headline6: TextStyle(fontSize: 16.0,color: darkGrey),
            subtitle1: TextStyle(fontSize: 18.0,color: darkGrey,),
            subtitle2: TextStyle(fontSize: 16.0,color: black,),
            bodyText1: TextStyle(fontSize: 14.0,color: darkGrey,),
            bodyText2: TextStyle(fontSize: 12.0,color: black,),),
        ),*/
        home: HomeScreen(),
     /* ),*/));
  }

}
